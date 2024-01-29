{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_default",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('post_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        object_to_string('sharedposts'),
        'created_time',
        object_to_string('sponsor_tags'),
        object_to_string('comments'),
        array_to_string('message_tags'),
        'name',
        object_to_string('reactions'),
        'id',
        object_to_string(adapter.quote('to')),
        'message',
        'permalink_url',
        array_to_string('actions'),
    ]) }} as _airbyte_post_hashid,
    tmp.*
from {{ ref('post_ab2') }} tmp
-- post
where 1 = 1

