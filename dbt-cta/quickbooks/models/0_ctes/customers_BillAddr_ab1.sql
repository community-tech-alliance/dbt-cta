{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers_base') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('BillAddr', ['CountrySubDivisionCode'], ['CountrySubDivisionCode']) }} as CountrySubDivisionCode,
    {{ json_extract_scalar('BillAddr', ['Long'], ['Long']) }} as Long,
    {{ json_extract_scalar('BillAddr', ['Country'], ['Country']) }} as Country,
    {{ json_extract_scalar('BillAddr', ['PostalCode'], ['PostalCode']) }} as PostalCode,
    {{ json_extract_scalar('BillAddr', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('BillAddr', ['City'], ['City']) }} as City,
    {{ json_extract_scalar('BillAddr', ['Line1'], ['Line1']) }} as Line1,
    {{ json_extract_scalar('BillAddr', ['Lat'], ['Lat']) }} as Lat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_base') }}
-- BillAddr at customers/BillAddr
where
    1 = 1
    and BillAddr is not null
