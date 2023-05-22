with source as (
    select * from {{ source('meta', 'configured_syncs') }}
)

, unnest_partner as (
    SELECT dag_id
, partner_name
    from source
    cross join unnest(source.partners)
)
select * from unnest_partner