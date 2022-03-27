{% test no_greater_than(model, column_name, n) %}


   select *
   from {{ model }}
   where {{ column_name }} > {{ n }}


{% endtest %}