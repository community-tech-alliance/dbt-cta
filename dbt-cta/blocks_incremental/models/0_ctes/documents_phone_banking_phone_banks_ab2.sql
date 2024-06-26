-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _airbyte_documents_phone_banking_phone_banks_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('documents_phone_banking_phone_banks_ab1') }}
    )
where rownum = 1
