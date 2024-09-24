-- ensures the base model contains only one row per _cta_hashid

select * from
    (
        select
            *,
            row_number() over (partition by _cta_hashid order by updated_at desc) as rownum
        from {{ ref('group_memberships_cte1') }}
    )
where rownum = 1
