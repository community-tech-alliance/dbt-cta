SELECT * FROM {{ source('cta', 'product_base') }}  _airbyte_emitted_at,
