Hi, I have a question
I have model _model_1 (materialized as a table), and after running I would like to create model_1 (a view) on top of the table, and grant permissions for that view
I accomplished that using a post hook like this:

´´´´
{{ 
    config(
    materialized = 'table',
    file_format = 'parquet',
    post_hook=[
      "CREATE OR REPLACE VIEW schema.model_1 AS (SELECT * FROM {{this}});",
      "GRANT READ_METADATA ON TABLE schema.model_1 TO `users`;",
      "GRANT SELECT ON schema.model_1 TO `users`;"
    ]
    )
}}
´´´´


But, I would like this to be a macro, the problem is I don't know how to remove the underscore of _model_1 for this macro to be used in several models,
I tried something like this:

´´´´
{% macro create_view_grant_permissions(model) %}
{%- set viewName = model.include(database=false) -%}
{% set sql %}
    CREATE OR REPLACE VIEW schema.{{ viewName[1:] }}
    AS (
        SELECT * FROM {{ model }}
    );

    GRANT READ_METADATA ON TABLE schema.{{ viewName[1:] }} TO `users`;

    GRANT SELECT on schema.{{ viewName[1:] }} to `users`;
{% endset %}
{% endmacro %}
´´´´

and adding: post-hook: "{{ create_view_grant_permissions(this) }}" in profile.yml
but, I get the following error:

´´´´
Compilation Error in model _model_1 (models/marts/core/_model_1.sql)
  getattr(): attribute name must be string
´´´´

What am I missing?