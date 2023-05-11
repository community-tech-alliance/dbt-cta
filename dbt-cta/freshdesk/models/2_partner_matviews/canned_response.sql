SELECT * FROM {{ source('cta', 'canned_response_base') }}  _airbyte_emitted_at,
