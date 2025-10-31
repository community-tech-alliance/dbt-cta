{{
    config(
        materialized = 'view',
        tags = [
            'airbyte-usage'
        ]
    )
}}

select
    -- pk
    connections.connection_id,
    -- ids
    connections.source_id,
    connections.workspace_id,
    -- attributes
    connections.connection_name,
    connections.namespace,
    sources.source_type,
    sources.billing_type
from {{ ref('connection') }} as connections
inner join {{ ref('source') }} as sources
    on connections.source_id = sources.source_id
