{% macro check_for_schema_changes(source_relation, target_relation) %}
   return ({'schema_changed': False})
{% endmacro %}