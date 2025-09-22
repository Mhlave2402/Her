<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400"></a></p>

<p align="center">
<a href="https://travis-ci.org/laravel/framework"><img src="https://travis-ci.org/laravel/framework.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains over 1500 video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the Laravel [Patreon page](https://patreon.com/taylorotwell).

### Premium Partners

- **[Vehikl](https://vehikl.com/)**
- **[Tighten Co.](https://tighten.co)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Cubet Techno Labs](https://cubettech.com)**
- **[Cyber-Duck](https://cyber-duck.co.uk)**
- **[Many](https://www.many.co.uk)**
- **[Webdock, Fast VPS Hosting](https://www.webdock.io/en)**
- **[DevSquad](https://devsquad.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel/)**
- **[OP.GG](https://op.gg)**
- **[WebReinvent](https://webreinvent.com/?utm_source=laravel&utm_medium=github&utm_campaign=patreon-sponsors)**
- **[Lendio](https://lendio.com)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## Split Payment Feature

The Split Payment feature allows users to split the cost of a ride with another user. The feature is implemented as a module in the Laravel backend and has a corresponding UI in the user and driver apps.

### Backend

The backend is implemented as a Laravel module called `SplitPaymentManagement`. It has the following components:

- **`SplitPayment` model:** Stores the details of the split payment, including the trip ID, the user who initiated the split, the user who the split is with, and the status of the split.
- **`SplitPaymentController`:** Handles the business logic for the split payment feature, including creating and accepting split payment requests.
- **API routes:** Exposes the split payment functionality to the frontend apps.

### Frontend

The frontend is implemented in the user and driver apps.

- **User app:** The user app has a `SplitPaymentScreen` that allows users to initiate a split payment request. The screen allows the user to select a contact from their phone to split the payment with.
- **Driver app:** The driver app displays the payment method on the ongoing ride screen. If the payment is split, it shows the details of the split.

## Travel with Male Companion Feature

The "Travel with Male Companion" feature allows female drivers to charge a surcharge when they are accompanied by a male passenger. The fee can be set in the admin panel.

### Backend

The backend has the following components:

- **`TripRequest` model:** The `with_male_companion` boolean field indicates whether the user is traveling with a male companion.
- **Fee structure:** The `getDiscountActualFareAttribute` method in the `TripRequest` model contains the logic for applying a surcharge when a female driver is accompanied by a male passenger. The surcharge is based on the `male_companion_fee` setting in the admin panel.
- **Admin Panel:** The admin panel has a new field in the "Fare & Penalty Settings" section to set the "Male Companion Fee".

### Frontend

The frontend is implemented in the user and driver apps.

- **User app:** The user app has a checkbox on the `set_destination_screen` that allows users to enable the "Travel with Male Companion" option. A warning message is displayed when the option is enabled.
- **Driver app:** The driver app displays whether the user is traveling with a male companion on the ongoing ride screen.

## SOS Button with Silent Alert

The "SOS Button with Silent Alert" feature allows users and drivers to send a silent alert to the admin panel in case of an emergency.

### Backend

The backend is implemented as a Laravel module called `SOSManagement`. It has the following components:

- **`SOS` model:** Stores the details of the SOS alert, including the user ID, trip ID, latitude, longitude, and an optional note.
- **`SOSController`:** Handles the business logic for the SOS feature, including creating SOS alerts.
- **`SOSAlert` event:** A real-time event that is broadcasted to the admin panel when an SOS is triggered.
- **API routes:** Exposes the SOS functionality to the frontend apps.

### Frontend

The frontend is implemented in the user and driver apps.

- **User app:** The user app has a `SosScreen` that allows users to send an SOS alert. The screen allows the user to add a note to the alert.
- **Driver app:** The driver app has a `SosScreen` that allows drivers to send an SOS alert. The screen allows the driver to add a note to the alert.

### Admin Panel

The admin panel listens for the `SOSAlert` event and displays an alert to the admin when an SOS is triggered.

## Live Trip Sharing

This feature allows users to share their live trip location with trusted contacts.

### API Endpoints

*   `POST /api/trip-requests/{tripRequest}/share`
    *   Generates a secure, expiring sharing link for a trip.
    *   The `{tripRequest}` parameter is the UUID of the trip request.
*   `POST /api/trip-requests/{tripRequest}/location`
    *   Updates the driver's location for a trip.
    *   The `{tripRequest}` parameter is the UUID of the trip request.
    *   The request body should contain the driver's `latitude` and `longitude`.
*   `GET /trip/share/{token}`
    *   Displays a web view with a live map of the trip.
    *   The `{token}` parameter is the secure token from the sharing link.

### Broadcasting

*   The `DriverLocationUpdated` event is broadcast on the `trip.{tripRequest}` private channel whenever the driver's location is updated.
*   The event contains the `tripRequest` model, which includes the driver's location.

## Shortfall Management

This feature allows drivers to record a shortfall when a user cannot pay the full trip fare. The unpaid amount is automatically split and added to the user's next 3 ride fares as small surcharges.

### Backend

The backend is implemented as a Laravel module called `TripManagement`. It has the following components:

- **`TripRequest` model:** The `TripRequest` model has been enhanced with the following fields:
    - `shortfall_amount` (float)
    - `amount_paid_in_cash` (float)
    - `is_shortfall_active` (boolean)
    - `shortfall_installments_remaining` (integer)
    - `shortfall_per_trip` (float)
    - `shortfall_recovery_completed` (boolean)
    - `shortfall_paid_total` (float)
    - `shortfall_percentage` (float)
- **`ShortfallController`:** Handles the business logic for the shortfall feature, including recording, adjusting, and canceling shortfalls.
- **API routes:** Exposes the shortfall functionality to the frontend apps.

### Admin Panel

The admin panel has the following features:

- **Shortfall Management Panel:**
    - View all shortfall-active users
    - View recovery progress: how many installments left, how much paid
    - Option to reset or cancel recovery manually if needed
- **Analytics / Reporting:**
    - Track total shortfalls by user
    - Driver-side summaries of shortfall recoveries

### New Features

- **Manual Adjustment of Recovery Terms:** Admins can manually adjust the recovery terms (e.g., split over 5 rides).
- **Percentage on Shortfalls:** Admins can add a percentage on these shortfalls.
- **"Pay Now" Option:** Users can pay their shortfall via their wallet.
- **Alerts:** Users are alerted when their shortfall is fully cleared.
- **Trust Score:** A "trust score" logic has been added for riders with unpaid balances.

## Service Availability & Hierarchy

This feature ensures that the system only assigns rides for services that are available, while allowing higher-tier vehicles to accept rides from lower tiers, with a driver-controlled opt-in for lower-tier rides.

### Backend

- **`VehicleCategory` model:** A `rank` integer field has been added to define the service hierarchy.
- **`User` model:** An `accepts_lower_tier_rides` boolean field has been added to allow drivers to opt-in to receive lower-tier ride requests.
- **`TripRequestService`:** The `findNearestDrivers` method has been updated to implement the service hierarchy logic.
- **`VehicleCategoryController`:** A new controller has been added to allow admins to manage vehicle categories and their ranks.

### Frontend

- **Driver app:** The `edit_profile_screen.dart` has been updated to include a checkbox for drivers to enable or disable the `accepts_lower_tier_rides` setting.

### Admin Panel

- **Vehicle Category Management:** A new section has been added to the admin panel to allow admins to create, edit, and delete vehicle categories, and to assign a rank to each category.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
