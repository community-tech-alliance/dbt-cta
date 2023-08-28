-- SQL model to get latest `date_updated` values for each sid
-- depends_on: {{ ref('messages_ab2') }}

select * from
    (
        select
            *,
            row_number() over (partition by sid order by date_updated desc) as rownum
        from {{ ref('messages_ab2') }}
    )
where rownum = 1
