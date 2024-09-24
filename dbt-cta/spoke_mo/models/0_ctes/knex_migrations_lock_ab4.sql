-- ensures the base model contains only one row per id

select * from
    (
        select
            *,
            row_number() over (partition by _airbyte_knex_migrations_lock_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('knex_migrations_lock_ab3') }}
    )
where rownum = 1
