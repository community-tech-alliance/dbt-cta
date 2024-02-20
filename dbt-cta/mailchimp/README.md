# Mailchimp

## Source tables

This dbt project configures the source table names in a YAML outside this repository, which enables CTA to test that functionality in a sync that (currently) we are not running for any partners.

The source table names 

### CTA (raw data & base tables):
- campaigns (in dataset `airbyte_internal` after switching to V2 of Airbyte's BQ Destination Connector)
- campaigns_base

### partner (materialized views):
- campaigns