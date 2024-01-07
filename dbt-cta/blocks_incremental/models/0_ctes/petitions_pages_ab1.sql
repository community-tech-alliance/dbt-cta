
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'petitions_pages') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   notes,
   notary_id,
   signatures_count,
   canvasser_id,
   county,
   extras,
   created_at,
   notary_signature,
   scan_number,
   number,
   updated_at,
   packet_id,
   shift_id,
   id,
   possible_fraud,
   box_number,
   notary_date,
   notary_seal,
   petition_book_id,
   signers_county,
   scan_file_data,
   created_by_user_id,
   canvasser_signature,
   notary_county,
   {{ dbt_utils.surrogate_key([
     'date',
    'notes',
    'notary_id',
    'signatures_count',
    'canvasser_id',
    'county',
    'extras',
    'notary_signature',
    'scan_number',
    'number',
    'packet_id',
    'shift_id',
    'id',
    'possible_fraud',
    'box_number',
    'notary_date',
    'notary_seal',
    'petition_book_id',
    'signers_county',
    'scan_file_data',
    'created_by_user_id',
    'canvasser_signature',
    'notary_county'
    ]) }} as _airbyte_petitions_pages_hashid
from {{ source('cta', 'petitions_pages') }}