{{
    config(
        materialized='ephemeral',
        tags = [
            'airbyte-usage'
        ]
    )
}}

select
    -- pk
    connectionId as connection_id,
    -- ids
    sourceId as source_id,
    workspaceId as workspace_id,
    -- attributes
    name as connection_name,
    namespaceFormat as namespace
from {{ source('airbyte_usage', 'connection') }}
