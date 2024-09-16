{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'keywords') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    active,
    cast(ended_at as {{ dbt.type_timestamp() }}) as ended_at,
    cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
    cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at,
    opt_in_path_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'active',
    'ended_at',
    'created_at',
    'updated_at',
    'opt_in_path_id'
    ]) }} as _airbyte_keywords_hashid
from {{ source('cta', 'keywords') }}
