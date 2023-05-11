SELECT * FROM {{ source('cta', 'canned_response_folder_base') }}  _airbyte_emitted_at,
