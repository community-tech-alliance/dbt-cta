-- ensures the base model contains only one row per id

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_knex_migrations_lock_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
FROM {{ ref('knex_migrations_lock_ab3') }}
)
where rownum=1