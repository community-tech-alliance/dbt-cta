
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'pivot_three') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   test,
   test2,
   test3,
   test4,
   test5,
   test6,
   test7,
   test8,
   test9,
   test10,
   test11,
   test12,
   test13,
   test14,
   test15,
   test16,
   test17,
   test18,
   test19,
   test20,
   turf_id,
   precinctid,
   ballotreceived,
   {{ dbt_utils.surrogate_key([
     'test',
    'test2',
    'test3',
    'test4',
    'test5',
    'test6',
    'test7',
    'test8',
    'test9',
    'test10',
    'test11',
    'test12',
    'test13',
    'test14',
    'test15',
    'test16',
    'test17',
    'test18',
    'test19',
    'test20',
    'turf_id',
    'precinctid',
    'ballotreceived'
    ]) }} as _airbyte_pivot_three_hashid
from {{ source('cta', 'pivot_three') }}