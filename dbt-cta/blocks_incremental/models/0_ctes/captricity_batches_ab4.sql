{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('captricity_batches_ab3') }}
select * from
    (
        select
            *,
            row_number() over (partition by id order by updated_at desc) as rownum
        from {{ ref('captricity_batches_ab3') }}
    )
where rownum = 1
