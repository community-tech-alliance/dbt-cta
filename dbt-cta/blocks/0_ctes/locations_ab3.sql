{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('locations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'street_address',
        'primary_point_of_contact',
        'notes',
        'contact_phone',
        boolean_to_string('has_hosted_event'),
        'city',
        'timezone',
        'latitude',
        'county',
        'extras',
        'created_at',
        'forms_per_hour',
        boolean_to_string('has_it_support'),
        'contact_email',
        'score',
        'rooms_available',
        'updated_at',
        'turf_id',
        boolean_to_string('has_public_transportation'),
        'id',
        'state',
        'email',
        'longitude',
        'hours',
        'contact_name',
        'maximum_occupancy',
        'largest_turnout',
        boolean_to_string('has_projector'),
        'parking_spots_available',
        'venue_info',
        'created_by_user_id',
        'location_type',
        'zipcode',
        'precinct',
        'geoid',
        'name',
        'phone_number',
        boolean_to_string('has_wifi'),
        'registration_forms_count',
        boolean_to_string('has_av'),
    ]) }} as _airbyte_locations_hashid,
    tmp.*
from {{ ref('locations_ab2') }} tmp
-- locations
where 1 = 1

