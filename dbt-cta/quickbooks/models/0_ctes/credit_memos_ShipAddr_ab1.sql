{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('credit_memos') }}
select
    _airbyte_credit_memos_hashid,
    {{ json_extract_scalar('ShipAddr', ['CountrySubDivisionCode'], ['CountrySubDivisionCode']) }} as CountrySubDivisionCode,
    {{ json_extract_scalar('ShipAddr', ['Long'], ['Long']) }} as Long,
    {{ json_extract_scalar('ShipAddr', ['PostalCode'], ['PostalCode']) }} as PostalCode,
    {{ json_extract_scalar('ShipAddr', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('ShipAddr', ['City'], ['City']) }} as City,
    {{ json_extract_scalar('ShipAddr', ['Line1'], ['Line1']) }} as Line1,
    {{ json_extract_scalar('ShipAddr', ['Lat'], ['Lat']) }} as Lat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('credit_memos') }} as table_alias
-- ShipAddr at credit_memos/ShipAddr
where 1 = 1
and ShipAddr is not null

