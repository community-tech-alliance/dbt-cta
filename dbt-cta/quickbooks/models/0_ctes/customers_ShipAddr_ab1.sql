{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers_base') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('ShipAddr', ['CountrySubDivisionCode'], ['CountrySubDivisionCode']) }} as CountrySubDivisionCode,
    {{ json_extract_scalar('ShipAddr', ['Long'], ['Long']) }} as Long,
    {{ json_extract_scalar('ShipAddr', ['Country'], ['Country']) }} as Country,
    {{ json_extract_scalar('ShipAddr', ['PostalCode'], ['PostalCode']) }} as PostalCode,
    {{ json_extract_scalar('ShipAddr', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('ShipAddr', ['City'], ['City']) }} as City,
    {{ json_extract_scalar('ShipAddr', ['Line1'], ['Line1']) }} as Line1,
    {{ json_extract_scalar('ShipAddr', ['Lat'], ['Lat']) }} as Lat,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_base') }}
-- ShipAddr at customers/ShipAddr
where
    1 = 1
    and ShipAddr is not null
