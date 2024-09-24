-- ensures the base model contains only one row per id

select * from
    (
        select
            *,
            row_number() over (partition by id order by _airbyte_extracted_at desc) as rownum
        from {{ ref('owned_phone_number_ab3') }}
    )
where rownum = 1
