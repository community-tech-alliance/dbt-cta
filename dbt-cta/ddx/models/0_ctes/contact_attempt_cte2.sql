-- ensures the base model contains only one row per unique combination of primary keys

select * from
    (
        select
            *,
            row_number() over (partition by _cta_hash_id order by datetime_pulled desc) as rownum
        from {{ ref('contact_attempt_cte1') }}
    )
where rownum = 1
