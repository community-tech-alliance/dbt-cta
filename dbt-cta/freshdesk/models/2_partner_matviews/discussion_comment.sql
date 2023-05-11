SELECT * FROM {{ source('cta', 'discussion_comment_base') }}  _airbyte_emitted_at,
