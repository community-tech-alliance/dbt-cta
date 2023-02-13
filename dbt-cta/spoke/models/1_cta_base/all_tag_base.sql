{{ config(
    cluster_by = "_cta_sync_datetime_utc",
    partition_by = {"field": "_cta_sync_datetime_utc", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_cta_sync_rowid',
) }}

select * from {{ source('cta','all_tag_raw') }}
where 1 = 1
{{ incremental_clause('_cta_sync_datetime_utc') }}
