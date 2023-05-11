SELECT * FROM {{ source('cta', 'discussion_topic_base') }}  _airbyte_emitted_at,
