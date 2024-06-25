-- ensures the base model contains only one row per unique combination of primary keys

select * from
    (
        select
            *,
            row_number() over (partition by _cta_hash_id order by _cta_loaded_at desc) as rownum
        from {{ ref('universe_builder_cte1') }}
    )
where rownum = 1
