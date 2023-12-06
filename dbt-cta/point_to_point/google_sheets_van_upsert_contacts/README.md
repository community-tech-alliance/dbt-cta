# Summary

This dbt takes the raw Google Sheets table synced to BQ by Airbyte and removes/renames columns so that the table can be used in a VAN rETL workflow.

This is not an actual sync we are running for any partners, but is intended to serve as a template for future point-to-point syncs that map columns from source data to columns needed in order to update a destination source using a Google Workflow (which runs a Cloud Function that expects data to be passed in a certain format).