-- ensures the base model contains only one row per id

select * from
    (
        select
            *,
            row_number() over (partition by id order by updated_at desc) as rownum
        from {{ ref('voter_registration_scan_visual_review_responses_ab3') }}
    )
where rownum = 1