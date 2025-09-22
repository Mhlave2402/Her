@extends('adminmodule::layouts.master')

@section('title', translate('Business_Info'))

@section('content')
    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <h2 class="fs-22 mb-4 text-capitalize">{{ translate('business_management') }}</h2>

            <div class="mb-3">
                @include('businessmanagement::admin.business-setup.partials._business-setup-inline')
            </div>

            <div class="row g-3">
                <div class="col-lg-6">
                    <div class="card collapsible-card-body">
                        <form action="{{ route('admin.business.setup.driver.store') }}?type=loyalty_point"
                              id="loyalty_point_form" method="post">
                            @csrf
                            <div class="card-header d-flex align-items-center gap-2 justify-content-between">
                                <h5 class="d-flex align-items-center gap-2 text-capitalize">
                                    <i class="bi bi-person-fill-gear"></i>
                                    {{ translate('Driver Can Earn Loyalty Point') }}
                                    <i class="bi bi-info-circle-fill text-primary cursor-pointer"
                                       data-bs-toggle="tooltip"
                                       title="{{ translate('configure_loyalty_point') }}"></i>
                                </h5>

                                <a href="javascript:" class="text-info fw-semibold fs-12 text-nowrap d-flex view-btn">
                                    <span class="text-underline">{{ translate('View') }}</span>
                                    <span><i class="tio-arrow-downward"></i></span>
                                </a>
                            </div>
                            <div class="card-body collapsible-card-content">
                                <div class="mb-4">
                                    <div class="d-flex align-items-center justify-content-between gap-2">
                                        <h6 class="fw-semibold text-capitalize text-capitalize">
                                            {{ translate('driver_can_earn_loyalty_point') }}</h6>
                                        <label class="switcher">
                                            <input class="switcher_input" type="checkbox" name="loyalty_points[status]"
                                                   id="loyalty_point_switch"
                                                {{ $settings->firstWhere('key_name', 'loyalty_points')?->value['status'] == 1 ? 'checked' : '' }}>
                                            <span class="switcher_control"></span>
                                        </label>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="equivalent_points"
                                           class="mb-2">{{ getCurrencyFormat(1) . ' ' . translate('equivalent_to_points') }}</label>
                                    <input type="tel" name="loyalty_points[value]" id="equivalent_points"
                                           class="form-control" required pattern="[1-9][0-9]{0,200}"
                                           title="Please input integer value. Ex:1,2,22,10"
                                           placeholder="{{ translate('Ex: 2') }}"
                                           value="{{ $settings->where('key_name', 'loyalty_points')->first()?->value['points'] }}">
                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="submit"
                                            class="btn btn-primary text-uppercase">{{ translate('submit') }}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card collapsible-card-body">
                        <form action="{{ route('admin.business.setup.driver.store') }}?type=maximum_parcel_request_accept_limit" id="maximumParcelRequestAcceptLimit" method="post">
                            @csrf
                            <div class="card-header d-flex align-items-center gap-2 justify-content-between">
                                <h5 class="d-flex align-items-center gap-2 text-capitalize">
                                    <i class="bi bi-person-fill-gear"></i>
                                    {{ translate('Driver Parcel Limit Setup') }}
                                    <i class="bi bi-info-circle-fill text-primary cursor-pointer"
                                       data-bs-toggle="tooltip"
                                       title="{{ translate('Set Parcel Delivery Limit') }}"></i>
                                </h5>

                                <a href="javascript:" class="text-info fw-semibold fs-12 text-nowrap d-flex view-btn">
                                    <span class="text-underline">{{ translate('View') }}</span>
                                    <span><i class="tio-arrow-downward"></i></span>
                                </a>
                            </div>
                            <div class="card-body collapsible-card-content">
                                <div class="mb-4">
                                    <div class="d-flex align-items-center justify-content-between gap-2">
                                        <h6 class="fw-semibold text-capitalize text-capitalize">
                                            {{ translate('Max. Parcel Req. Accept Limit') }}
                                            <i class="bi bi-info-circle-fill text-primary cursor-pointer"
                                               data-bs-toggle="tooltip"
                                               title="{{ translate('Set the maximum number of parcels delivery a driver can carry at once. Once the limit is reached, the driver cannot accept new parcel requests until existing deliveries are completed.') }}"></i>
                                        </h6>
                                        <label class="switcher">
                                            <input class="switcher_input" type="checkbox"
                                                   name="maximum_parcel_request_accept_limit[status]"
                                                   id="maximum_parcel_request_accept_limit"
                                                {{ $settings->firstWhere('key_name', 'maximum_parcel_request_accept_limit')?->value['status'] == 1 ? 'checked' : '' }}>
                                            <span class="switcher_control"></span>
                                        </label>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="mb-2">{{ translate('Limit') }}</label>
                                    <input type="tel" name="maximum_parcel_request_accept_limit[value]"
                                           class="form-control" required pattern="[1-9][0-9]{0,200}"
                                           title="Please input integer value. Ex:1,2,22,10"
                                           placeholder="{{ translate('Ex: 2') }}"
                                           value={{ $settings->where('key_name', 'maximum_parcel_request_accept_limit')->first()?->value['limit'] }}>
                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="submit"
                                            class="btn btn-primary text-uppercase">{{ translate('submit') }}</button>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="d-flex align-items-center gap-2 text-capitalize">
                                <i class="bi bi-person-fill-gear"></i>
                                {{ translate('driver_review') }}
                                <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip"
                                   title="{{ translate('configure_driver_review') }}"></i>
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between gap-2">
                                <h6 class="fw-medium d-flex align-items-center fw-medium gap-2 text-capitalize">
                                    {{ translate('driver_can_review_customer') }}
                                    <i class="bi bi-info-circle-fill text-primary cursor-pointer"
                                       data-bs-toggle="tooltip"
                                       title="{{ translate('configure_that_driver_can_give_review_to_customer_or_not') }}">
                                    </i>
                                </h6>
                                <label class="switcher">
                                    <input class="switcher_input" name="{{ DRIVER_REVIEW }}" type="checkbox"
                                           data-type="{{ DRIVER_SETTINGS }}" id="driverReview"
                                        {{ $settings->firstWhere('key_name', DRIVER_REVIEW)?->value == 1 ? 'checked' : '' }}>
                                    <span class="switcher_control"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">
                            <div class="d-flex flex-wrap align-items-center gap-2 justify-content-between">
                                <h5 class="d-flex align-items-center gap-2 text-capitalize">
                                    <i class="bi bi-person-fill-gear"></i>
                                    {{ translate('Driver Level') }}
                                    <i class="bi bi-info-circle-fill text-primary cursor-pointer"
                                       data-bs-toggle="tooltip"
                                       title="{{ translate('Enable this, customers will gain access to level-specific features and benefits') }}"></i>
                                </h5>
                                <a href="{{ route('admin.driver.level.index') }}"
                                   class="text-primary fw-semibold d-flex gap-2 align-items-center">
                                    {{ translate('Go to settings') }}
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between gap-2">
                                <h6 class="fw-medium d-flex align-items-center fw-medium gap-2 text-capitalize">
                                    {{ translate('active_level_feature') }}
                                </h6>
                                <label class="switcher">
                                    <input class="switcher_input update-business-setting" id="customerLevel"
                                           name="driver_level" type="checkbox" data-name="driver_level"
                                           data-type="driver_settings"
                                           data-url="{{ route('admin.business.setup.update-business-setting') }}"
                                           data-icon="{{ ($settings->firstWhere('key_name', 'driver_level')->value ?? 0) == 0 ? asset('public/assets/admin-module/img/level-up-on.png') : asset('public/assets/admin-module/img/level-up-off.png') }}"
                                           data-title="{{ ($settings->firstWhere('key_name', 'driver_level')->value ?? 0) == 0 ? translate('By Turning ON Level Feature') . '?' : translate('By Turning OFF Level Feature') . '?' }}"
                                           data-sub-title="{{ ($settings->firstWhere('key_name', 'driver_level')->value ?? 0) == 0 ? translate('If you turn ON level feature, customer will see this feature on app.') : translate('If you turning off customer level feature, please do it at the beginning stage of business. Because once driver use this feature & you will off this feature they will be confused or worried about it.') }}"
                                        {{ ($settings->firstWhere('key_name', 'driver_level')->value ?? 0) == 1 ? 'checked' : '' }}>
                                    <span class="switcher_control"></span>
                                </label>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="card text-capitalize">
                        <div class="collapsible-card-body">
                            <div class="card-header d-flex align-items-center justify-content-between gap-2">
                                <div class="w-0 flex-grow-1">
                                    <h5 class="mb-2">
                                        {{ translate('Update_Vehicle') }}
                                        <i class="bi bi-info-circle-fill text-primary cursor-pointer"
                                           data-bs-toggle="tooltip"
                                           title="{{ translate('If a driver updates the details of an existing vehicle, certain changes may require admin approval.') }}"></i>
                                    </h5>
                                    <div class="fs-12">
                                        {{ translate('When driver update a existing vehicle which info need admin approval.') }}
                                    </div>
                                </div>

                                <div class="d-flex gap-2 align-items-center">
                                    <a href="javascript:" class="text-info fw-semibold fs-12 text-nowrap d-flex view-btn">
                                        <span class="text-underline">{{ translate('View') }}</span>
                                        <span><i class="tio-arrow-downward"></i></span>
                                    </a>

                                    <label class="switcher">
                                        <input class="switcher_input collapsible-card-switcher update-business-setting"
                                            id="updateVehicle" type="checkbox" name="update_vehicle_status"
                                            data-name="update_vehicle_status" data-type="{{ DRIVER_SETTINGS }}"
                                            data-url="{{ route('admin.business.setup.update-business-setting') }}"
                                            data-icon="{{ ($settings->firstWhere('key_name', 'update_vehicle_status')?->value ?? 0) == 1 ? asset('public/assets/admin-module/img/media/car5.png') : asset('public/assets/admin-module/img/media/car4.png') }}"
                                            data-title="{{ translate('Are you sure?') }}"
                                            data-sub-title="{{ ($settings->firstWhere('key_name', 'update_vehicle_status')?->value ?? 0) == 1 ? translate('Do you want to turn OFF update vehicle?') : translate('Do you want to turn ON update vehicle?') }}"
                                            data-confirm-btn="{{ ($settings->firstWhere('key_name', 'update_vehicle_status')?->value ?? 0) == 1 ? translate('Turn Off') : translate('Turn On') }}"
                                            {{ ($settings->firstWhere('key_name', 'update_vehicle_status')?->value ?? 0) == 1 ? 'checked' : '' }}>
                                        <span class="switcher_control"></span>
                                    </label>
                                </div>
                            </div>


                            <div class="card-body collapsible-card-content">
                                <form
                                    action="{{ route('admin.business.setup.driver.vehicle-update') . '?type=' . DRIVER_SETTINGS }}"
                                    id="updateVehicleForm" method="POST">
                                    @csrf
                                    <div class="d-flex gap-4 justify-content-between flex-wrap flex-column flex-sm-row">
                                        @foreach(UPDATE_VEHICLE as $updateVehicle)
                                            <label class="custom-checkbox">
                                                <input type="checkbox" class="module-checkbox text-capitalize"
                                                       name="update_vehicle[]"
                                                       value="{{$updateVehicle}}" {{in_array($updateVehicle, $settings->firstWhere('key_name', 'update_vehicle')?->value ??[], true) ? "checked" : ""}}>
                                                {{translate($updateVehicle)}}
                                            </label>
                                        @endforeach
                                    </div>
                                    <div class="d-flex justify-content-end gap-3 mt-5">
                                        <button type="reset"
                                                class="btn btn-secondary min-w-100px justify-content-center">{{ translate('cancel') }}</button>
                                        <button type="submit"
                                                class="btn btn-primary min-w-100px justify-content-center">{{ translate('save') }}</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <div class="d-flex flex-wrap align-items-center gap-2 justify-content-between">
                                <h5 class="d-flex align-items-center gap-2 text-capitalize">
                                    <i class="bi bi-person-fill-gear"></i>
                                    {{ translate('Driver Assistance') }}
                                    <i class="bi bi-info-circle-fill text-primary cursor-pointer"
                                       data-bs-toggle="tooltip"
                                       title="{{ translate('need_content') }}"></i>
                                </h5>
                                <a href="#"
                                   class="text-primary fw-semibold d-flex gap-2 align-items-center">
                                    {{ translate('Go to settings') }}
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between gap-2">
                                <h6 class="fw-medium d-flex align-items-center fw-medium gap-2 text-capitalize">
                                    {{ translate('Active Assistance Feature') }}
                                </h6>
                                <label class="switcher">
                                    <input class="switcher_input update-business-setting" id="customerLevel"
                                           name="driver_level" type="checkbox" data-name="driver_level"
                                           data-type="driver_settings"
                                           data-url="{{ route('admin.business.setup.update-business-setting') }}"
                                           data-icon="{{ ($settings->firstWhere('key_name', 'driver_level')->value ?? 0) == 0 ? asset('public/assets/admin-module/img/level-up-on.png') : asset('public/assets/admin-module/img/level-up-off.png') }}"
                                           data-title="{{ ($settings->firstWhere('key_name', 'driver_level')->value ?? 0) == 0 ? translate('By Turning ON Level Feature') . '?' : translate('By Turning OFF Level Feature') . '?' }}"
                                           data-sub-title="{{ ($settings->firstWhere('key_name', 'driver_level')->value ?? 0) == 0 ? translate('If you turn ON level feature, customer will see this feature on app.') : translate('If you turning off customer level feature, please do it at the beginning stage of business. Because once driver use this feature & you will off this feature they will be confused or worried about it.') }}"
                                        {{ ($settings->firstWhere('key_name', 'driver_level')->value ?? 0) == 1 ? 'checked' : '' }}>
                                    <span class="switcher_control"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="card text-capitalize">
                        <div class="collapsible-card-body">
                            <div class="card-header d-flex align-items-center justify-content-between gap-2">
                                <div class="w-0 flex-grow-1">
                                    <h5 class="mb-2">
                                        {{ translate('Driver Face Verification') }}
                                        <i class="bi bi-info-circle-fill text-primary cursor-pointer"
                                           data-bs-toggle="tooltip"
                                           title="{{ translate('need_content ') }}"></i>
                                    </h5>
                                    <div class="fs-12">
                                        {{ translate('Enable face verification to ensure only authorized drivers can go online') }}.
                                    </div>
                                </div>

                                <div class="d-flex gap-2 align-items-center">
                                    <a href="javascript:" class="text-info fw-semibold fs-12 text-nowrap d-flex view-btn">
                                        <span class="text-underline">{{ translate('View') }}</span>
                                        <span><i class="tio-arrow-downward"></i></span>
                                    </a>

                                    <label class="switcher">
                                        <input class="switcher_input collapsible-card-switcher update-business-setting"
                                            id="updateVehicle" type="checkbox" name="update_vehicle_status"
                                            data-name="update_vehicle_status" data-type="{{ DRIVER_SETTINGS }}"
                                            data-url="{{ route('admin.business.setup.update-business-setting') }}"
                                            data-icon="{{ ($settings->firstWhere('key_name', 'update_vehicle_status')?->value ?? 0) == 1 ? asset('public/assets/admin-module/img/media/car5.png') : asset('public/assets/admin-module/img/media/car4.png') }}"
                                            data-title="{{ translate('Are you sure?') }}"
                                            data-sub-title="{{ ($settings->firstWhere('key_name', 'update_vehicle_status')?->value ?? 0) == 1 ? translate('Do you want to turn OFF update vehicle?') : translate('Do you want to turn ON update vehicle?') }}"
                                            data-confirm-btn="{{ ($settings->firstWhere('key_name', 'update_vehicle_status')?->value ?? 0) == 1 ? translate('Turn Off') : translate('Turn On') }}"
                                            {{ ($settings->firstWhere('key_name', 'update_vehicle_status')?->value ?? 0) == 1 ? 'checked' : '' }}>
                                        <span class="switcher_control"></span>
                                    </label>
                                </div>
                            </div>

                            <div class="card-body collapsible-card-content">
                                <form action="{{ route('admin.business.setup.driver.vehicle-update') . '?type=' . DRIVER_SETTINGS }}" id="updateVehicleForm" method="POST">
                                    @csrf
                                    <div class="p-3 bg-light rounded">
                                        <h6 class="mb-2">{{ translate('When Driver Need to Verify') }}</h6>
                                        <div class="bg-white card-body rounded">
                                            <div class="row g-4">
                                                <div class="col-md-6">
                                                    <div class="d-flex gap-2">
                                                        <input class="form-check-input checkbox--input" type="checkbox" name="cash_on_delivery" id="cash_on_delivery" value="1" checked="">
                                                        <div class="flex-grow-1">
                                                            <label for="cash_on_delivery" class="form-label text-dark fw-semibold mb-1 user-select-none">
                                                                {{translate('Verify When Sign Up')}}
                                                            </label>
                                                            <p class="fs-12 mb-0">
                                                                {{ translate('If it is enabled, the driver must verify their identity during registration.') }}
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="d-flex gap-2">
                                                        <input class="form-check-input checkbox--input" type="checkbox" name="digital_payment" id="digital_payment" value="1" checked="">
                                                        <div class="flex-grow-1">
                                                            <label for="digital_payment" class="form-label text-dark fw-semibold mb-1 user-select-none d-flex gap-1 align-items-center">
                                                                {{ translate('Verify Periodically') }}
                                                            </label>
                                                            <p class="fs-12 mb-0">
                                                                {{ translate('If it is enabled, the driver must verify their identity based on periodic time setup. Setup will appear when you select this option') }}.
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="p-3 bg-white rounded mt-3">
                                            <div class="form-group mb-20px">
                                                <h6 class="mb-3">{{ translate('Choose When Verify Periodically') }}</h6>
                                                <div class="bg-white p-3 rounded border">
                                                    <div class="row g-4">
                                                        <div class="col-xl-4 col-md-6">
                                                            <div class="custom-radio">
                                                                <input class="form-check-input radio--input radio--input_lg" type="radio" name="verify_periodically" id="within_time" value="email">
                                                                <label for="within_time" class="flex-grow-1">
                                                                    <h6>{{ translate('Verify Within Time') }}</h6>
                                                                    <p class="fs-12 mb-2">
                                                                        {{ translate('Driver needs to verify their identity within the selected time period after open app or trip accept') }}.
                                                                    </p>
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-xl-4 col-md-6">
                                                            <div class="custom-radio">
                                                                <input class="form-check-input radio--input radio--input_lg" type="radio" value="phone" name="verify_periodically" id="go_online" checked="">
                                                                <label for="go_online" class="flex-grow-1">
                                                                    <h6>{{ translate('When Go Online') }}</h6>
                                                                    <p class="fs-12 mb-2">
                                                                        {{ translate('Driver must verify their identity each day before going online') }}.
                                                                    </p>
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-xl-4 col-md-6">
                                                            <div class="custom-radio">
                                                                <input class="form-check-input radio--input radio--input_lg" type="radio" value="phone" name="verify_periodically" id="trip_randomly" checked="">
                                                                <label for="trip_randomly" class="flex-grow-1">
                                                                    <h6>{{ translate('When Start Trip Randomly') }}</h6>
                                                                    <p class="fs-12 mb-2">
                                                                        {{ translate('Drivers will be randomly prompted to verify their identity when starting a trip after completing the specified number of trips') }}.
                                                                    </p>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row mt-1 g-3">
                                                    <div class="col-md-6">
                                                        <label class="form-label">
                                                            {{ translate('setup_Time') }}
                                                            <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                                                        </label>
                                                        <div class="input-group input--group">
                                                            <input type="number" min="0" max="9999999" class="form-control" name="customer_discount_validity" value="" placeholder="Ex : 20">
                                                            <select class="form-select" name="customer_discount_validity_type">
                                                                <option value="day" selected>Day</option>
                                                                <option value="week">Week</option>
                                                                <option value="month">Month</option>
                                                                <option value="year">Year</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">
                                                            {{ translate('Trigger Time') }}
                                                            <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="Need content"></i>
                                                        </label>
                                                        <div class="d-flex align-items-center flex-wrap gap-2 h-auto min-h-45px form-control">
                                                            <div class="flex-grow-1">
                                                                <input type="radio" name="increase_rate" value="when_open_app" id="when_open_app" checked="">
                                                                <label for="when_open_app">{{ translate('When Open App') }}</label>
                                                            </div>

                                                            <div class="flex-grow-1">
                                                                <input type="radio" name="increase_rate" value="when_trip_accept" id="when_trip_accept">
                                                                <label for="when_trip_accept">{{ translate('When Trip Accept') }}</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row align-items-center mt-1 g-3">
                                                    <div class="col-md-4">
                                                        <h6 class="mb-1">{{ translate('Random Verification Trigger') }}</h6>
                                                        <p class="fs-12">{{ translate('Set after how many trips random verification Trigger') }}</p>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label class="form-label">
                                                            {{ translate('Set Trip') }}
                                                            <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="Need content"></i>
                                                        </label>
                                                        <input type="text" class="form-control" placeholder="{{ translate('Ex : 20') }}">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="pt-4">
                                        <div class="p-20 rounded bg-light">
                                            <div class="row align-items-center g-3">
                                                <div class="col-md-4">
                                                    <h6 class="mb-2">{{ translate('Driver Verification Deadline') }}</h6>
                                                    <div class="fs-12 max-w-370">
                                                        {{ translate('Set the verification deadline for drivers after registration.') }}
                                                    </div>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="mb-20">
                                                        <label class="form-label">
                                                            {{ translate('setup_Time') }}
                                                            <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                                                        </label>
                                                        <div class="input-group input--group">
                                                            <input type="number" min="0" max="9999999" class="form-control" name="customer_discount_validity" value="" placeholder="Ex : 20">
                                                            <select class="form-select" name="customer_discount_validity_type">
                                                                <option value="day" selected>Day</option>
                                                                <option value="week">Week</option>
                                                                <option value="month">Month</option>
                                                                <option value="year">Year</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex align-items-center justify-content-between gap-2 form-control">
                                                        <div>{{ translate('Unverified accounts will be suspended') }}.</div>
                                                        <label class="switcher">
                                                            <input class="switcher_input status-change" type="checkbox" checked="">
                                                            <span class="switcher_control"></span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="border-bottom border-top my-4"></div>

                                            <div class="row align-items-center g-3">
                                                <div class="col-md-4">
                                                    <h6 class="mb-2">{{ translate('Driver can Try Again After') }}</h6>
                                                    <div class="fs-12 max-w-370">
                                                        {{ translate('Set how long the driver must wait before retrying verification after 3 failed attempts') }}.
                                                    </div>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="d-flex align-items-center justify-content-between gap-2 form-control mb-20">
                                                        <div>{{ translate('Status') }}.</div>
                                                        <label class="switcher">
                                                            <input class="switcher_input status-change" type="checkbox" checked="">
                                                            <span class="switcher_control"></span>
                                                        </label>
                                                    </div>
                                                    <div>
                                                        <label class="form-label">
                                                            {{ translate('setup_Time') }}
                                                            <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                                                        </label>
                                                        <div class="input-group input--group">
                                                            <input type="number" min="0" max="9999999" class="form-control" name="customer_discount_validity" value="" placeholder="Ex : 20">
                                                            <select class="form-select" name="customer_discount_validity_type">
                                                                <option value="day" selected>Day</option>
                                                                <option value="week">Week</option>
                                                                <option value="month">Month</option>
                                                                <option value="year">Year</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-end gap-3 mt-4">
                                        <button type="reset" class="btn btn-secondary min-w-100px justify-content-center">{{ translate('cancel') }}</button>
                                        <button type="submit" class="btn btn-primary min-w-100px justify-content-center">{{ translate('save') }}</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Main Content -->
@endsection

@push('script')
    <script src="{{ asset('public/assets/admin-module/js/business-management/business-setup/driver.js') }}"></script>

    <script>
        "use strict";
        let permission = false;
        @can('business_edit')
            permission = true;
        @endcan

        $('#driverReview').on('change', function () {
            let url = '{{ route('admin.business.setup.update-business-setting') }}';
            updateBusinessSetting(this, url)
        })

        function updateBusinessSetting(obj, url) {
            if (!permission) {
                toastr.error('{{ translate('you_donot_have_enough_permission_to_update_this_settings') }}');

                let checked = $(obj).prop("checked");
                let status = checked === true ? 1 : 0;
                if (status === 1) {
                    $('#' + obj.id).prop('checked', false)

                } else if (status === 0) {
                    $('#' + obj.id).prop('checked', true)
                }
                return;
            }

            let value = $(obj).prop('checked') === true ? 1 : 0;
            let name = $(obj).attr('name');
            let type = $(obj).data('type');
            let checked = $(obj).prop("checked");
            let status = checked === true ? 1 : 0;


            Swal.fire({
                title: '{{ translate('are_you_sure') }}?',
                text: '{{ translate('want_to_change_status') }}',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: 'var(--bs-primary)',
                cancelButtonColor: 'default',
                cancelButtonText: '{{ translate('no') }}',
                confirmButtonText: '{{ translate('yes') }}',
                reverseButtons: true
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        url: url,
                        data: {
                            value: value,
                            name: name,
                            type: type
                        },
                        success: function () {
                            toastr.success("{{ translate('status_changed_successfully') }}");
                        },
                        error: function () {
                            if (status === 1) {
                                $('#' + obj.id).prop('checked', false)
                            } else if (status === 0) {
                                $('#' + obj.id).prop('checked', true)
                            }
                            toastr.error("{{ translate('status_change_failed') }}");
                        }
                    });
                } else {

                    if (status === 1) {
                        $('#' + obj.id).prop('checked', false)
                    } else if (status === 0) {
                        $('#' + obj.id).prop('checked', true)
                    }
                }
            })
        }

        // Collapse card with switcher
        function collapsibleCard(thisInput) {
            let $card = thisInput.closest('.collapsible-card-body');
            let $content = $card.children('.collapsible-card-content');
            if (thisInput.prop('checked')) {
                $content.slideDown();
            } else {
                $content.slideUp();
            }
        }

        $('.collapsible-card-switcher').each(function () {
            collapsibleCard($(this))
        });
        // Collapse card with switcher ends
    </script>

    <script>
        $('#loyalty_point_form').on('submit', function (e) {
            if (!permission) {
                toastr.error('{{ translate('you_donot_have_enough_permission_to_update_this_settings') }}');
                e.preventDefault();
            }
        });
    </script>
    <script>
        $(document).ready(function () {
            const $switcher = $('#maximum_parcel_request_accept_limit');
            const $inputField = $('input[name="maximum_parcel_request_accept_limit[value]"]');

            // Initial state
            $inputField.prop('disabled', !$switcher.is(':checked'));

            // Listen for changes
            $switcher.on('change', function () {
                $inputField.prop('disabled', !$(this).is(':checked'));
            });
        });
    </script>
@endpush
