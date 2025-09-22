# Configurable Fee Structure for Features

This document outlines the implementation of a comprehensive and configurable fee structure for premium features, starting with "Travel with Male Companion".

## 1. Database Schema

The following tables have been added to the database:

-   `feature_fee_configs`: Stores the rules for applying fees.
-   `feature_fee_audit_logs`: Logs all changes to the fee configurations.
-   `trip_feature_charges`: Stores the fees applied to each trip.

For detailed schema information, refer to the migration files:
-   `2025_08_11_000000_create_feature_fee_configs_table.php`
-   `2025_08_11_000001_create_feature_fee_audit_logs_table.php`
-   `2025_08_11_000002_create_trip_feature_charges_table.php`

## 2. API Contracts

### 2.1. Get Applicable Fees

This endpoint is used to get a preview of the fees that will be applied to a trip.

-   **URL**: `GET /api/v1/fees/apply`
-   **Query Parameters**:
    -   `zone_id` (uuid, required)
    -   `vehicle_type` (string, required)
    -   `fare` (numeric, required)
    -   `distance` (numeric, required)
    -   `duration` (numeric, required)
    -   `features[]` (array, required)
-   **Success Response**:
    ```json
    {
      "applied_fees": [
        {
          "feature_key": "male_companion",
          "config_id": 45,
          "model": "flat",
          "amount": 50.00,
          "currency": "ZAR",
          "display_label": "Male Companion Fee"
        }
      ],
      "total_feature_fees": 50.00,
      "fare_with_features": 250.00
    }
    ```

### 2.2. Apply at Ride Creation

The existing `POST /api/v1/trips` endpoint is used.

-   **Payload**: Include a `selected_features` array in the request body.
    ```json
    {
      "selected_features": ["male_companion"]
    }
    ```

### 2.3. Trip Retrieval

The existing `GET /api/v1/trips/{id}` endpoint now includes a `feature_charges` array in the response.

## 3. Admin Dashboard

A new set of API endpoints has been created to manage the feature fee configurations from the admin dashboard.

-   **List configs**: `GET /api/v1/admin/feature-fee-configs`
-   **Create config**: `POST /api/v1/admin/feature-fee-configs`
-   **Show config**: `GET /api/v1/admin/feature-fee-configs/{id}`
-   **Update config**: `PUT /api/v1/admin/feature-fee-configs/{id}`
-   **Delete config**: `DELETE /api/v1/admin/feature-fee-configs/{id}`
-   **Audit logs**: `GET /api/v1/admin/feature-fee-configs/{configId}/audit-logs`

## 4. Flutter App Behavior

### User App

1.  When a user selects a feature (e.g., "Male Companion"), call `GET /api/v1/fees/apply` to get the updated fare preview.
2.  Display the fee breakdown clearly to the user.
3.  On trip confirmation, the server will lock the fee and store it.
4.  The trip history and invoice should show the feature fee as a separate line item.

### Driver App

1.  On a new trip offer, display a badge or indicator if a special feature like "Male Companion" is selected.
2.  The driver's earnings breakdown should clearly show the income from the feature fee, based on the configured `payout_rule`.

## 5. Business Rules

-   **Priority**: If multiple fee configurations match a trip, the one with the highest `priority` value will be used.
-   **Currency**: The fee is calculated in the currency of the trip's zone.
-   **Payouts**: The `payout_rule` JSON field in `feature_fee_configs` determines the split of the fee between the driver and the platform. Example: `{"driver_pct": 60, "platform_pct": 40}`.

## 6. QA / Test Cases

-   Create a flat fee config and verify it's applied correctly.
-   Create a per-km fee config and verify the calculation.
-   Create overlapping configs with different priorities and ensure the correct one is chosen.
-   Deactivate a config and ensure no fee is applied.
-   Test in different zones to verify correct currency usage.
