SELECT * FROM {{ source('cta', 'solution_article_base') }}  _airbyte_emitted_at,
