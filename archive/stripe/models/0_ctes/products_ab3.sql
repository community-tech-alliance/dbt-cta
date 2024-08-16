{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'url',
        'name',
        'type',
        boolean_to_string('active'),
        array_to_string('images'),
        'object',
        'caption',
        'created',
        'updated',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        boolean_to_string('shippable'),
        array_to_string('attributes'),
        'unit_label',
        'description',
        array_to_string('deactivate_on'),
        object_to_string('package_dimensions'),
        'statement_descriptor',
    ]) }} as _airbyte_products_hashid,
    tmp.*
from {{ ref('products_ab2') }} as tmp
-- products
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

