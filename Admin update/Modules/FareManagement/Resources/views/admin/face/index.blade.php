@extends('adminmodule::layouts.master')

@section('title', translate('Trip_Fare_Setup'))

@push('css_or_js')
    <link rel="stylesheet" href="{{asset('public/assets/admin-module/plugins/daterangepicker/daterangepicker.css')}}">
@endpush

@section('content')
    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <div class="d-flex flex-wrap justify-content-between gap-2 mb-4">
                <h2 class="fs-22 mb-2 text-capitalize">{{ translate('Driver Verification Need') }}</h2>
                <h5 class="d-flex align-items-center gap-2 text-dark fw-medium cursor-pointer read-instruction" data-bs-toggle="offcanvas" data-bs-target="#howItWork-offcanvas">
                    {{ translate('How it Works') }}
                    <i class="bi bi-info-circle"></i>
                </h5>
            </div>

            <div class="card">
                <div class="card-body">
                    <div class="table-top d-flex flex-wrap gap-10 justify-content-between">
                        <form action="#" class="search-form search-form_style-two">
                            <div class="input-group search-form__input_group">
                                <span class="search-form__icon">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input type="search" name="search" value="" class="theme-input-style search-form__input" placeholder="{{ translate('Search here...') }}">
                            </div>
                            <button type="submit" class="btn btn-primary">{{ translate('Search') }}</button>
                        </form>

                        <div class="d-flex flex-wrap gap-3">
                            <a href="#" class="btn btn-outline-primary px-3" data-bs-toggle="tooltip" data-bs-title="Refresh">
                                <i class="bi bi-arrow-repeat"></i>
                            </a>

                            <div class="dropdown">
                                <button type="button" class="btn btn-outline-primary" data-bs-toggle="dropdown">
                                    <i class="bi bi-download"></i>
                                    {{ translate('Download') }}
                                    <i class="bi bi-caret-down-fill"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                                    <li><a class="dropdown-item" href="#">{{ translate('Excel') }}</a></li>
                                </ul>
                            </div>

                            <button type="button" class="btn btn-outline-primary" data-bs-toggle="offcanvas" data-bs-target="#filter-verification-offcanvas">
                                <i class="bi bi-funnel-fill"></i>
                                {{ translate('Filter') }}
                            </button>
                        </div>
                    </div>

                    <div id="trip-list-view">
                        <div class="table-responsive mt-3">
                            <table class="table table-borderless align-middle table-hover">
                                <thead class="table-light align-middle text-capitalize text-nowrap">
                                    <tr>
                                        <th>{{ translate('SL') }}</th>
                                        <th>{{ translate('Driver  Info') }}</th>
                                        <th>{{ translate('Attempts Made') }}</th>
                                        <th>{{ translate('Last Attempt Time') }}</th>
                                        <th>{{ translate('Verification Status	') }}</th>
                                        <th class="text-center">{{ translate('Action') }}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>
                                            <div class="media align-items-center gap-2">
                                                <img width="40" src="{{ asset('public/assets/admin-module/img/avatar/avatar.png') }}" class="dark-support w-40px rounded fit-object" alt="">
                                                <div class="media-body">
                                                    <div class="mb-1">Jenny Wilson</div>
                                                    <a href="tel:+0902342734">+0902342734</a>
                                                </div>
                                            </div>
                                        </td>
                                        <td>0</td>
                                        <td>
                                            2025-03-13
                                            <br>
                                            03:30 PM
                                        </td>
                                        <td>
                                            <span class="badge badge-primary">{{ translate('Skipped') }}</span>
                                        </td>
                                        <td class="text-center action">
                                            <div class="d-flex justify-content-center gap-2 align-items-center">
                                                <a href="#" class="btn btn-outline-success btn-action" data-bs-toggle="offcanvas" data-bs-target="#view-offcanvas">
                                                    <i class="bi bi-eye-fill"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>
                                            <div class="media align-items-center gap-2">
                                                <img width="40" src="{{ asset('public/assets/admin-module/img/avatar/avatar.png') }}" class="dark-support w-40px rounded fit-object" alt="">
                                                <div class="media-body">
                                                    <div class="mb-1">Jenny Wilson</div>
                                                    <a href="tel:+0902342734">+0902342734</a>
                                                </div>
                                            </div>
                                        </td>
                                        <td>0</td>
                                        <td>
                                            N/A
                                        </td>
                                        <td>
                                            <span class="badge badge-danger">{{ translate('Failed') }}</span>
                                        </td>
                                        <td class="text-center action">
                                            <div class="d-flex justify-content-center gap-2 align-items-center">
                                                <a href="#" class="btn btn-outline-success btn-action" data-bs-toggle="offcanvas" data-bs-target="#view-offcanvas">
                                                    <i class="bi bi-eye-fill"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {{-- Zone List Offcanvas --}}
    <div class="offcanvas offcanvas-end" id="view-offcanvas" style="--bs-offcanvas-width: 490px">
        <div class="offcanvas-header">
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            <h4 class="offcanvas-title flex-grow-1 text-center">
                {{ translate('Driver Verification Request') }}
            </h4>
        </div>
        <div class="offcanvas-body scrollbar-thin">
            <div class="d-flex flex-wrap gap-2 justify-content-between align-items-start">
                <div class="media align-items-center gap-2">
                    <img width="100" src="{{ asset('public/assets/admin-module/img/avatar/avatar.png') }}" class="dark-support w-100px rounded fit-object" alt="">
                    <div class="media-body d-flex flex-column gap-1">
                        <h6 class="mb-1">Jonathan Mathew</h6>
                        <div class="fs-12">ID #0902342734</div>
                        <a href="tel:+0902342734" class="fs-12">+0902342734</a>
                        <div class="d-flex align-items-center gap-2 flex-wrap">
                            <span class="badge badge-primary">{{ translate('Level - 1') }}</span>
                            <div class="fs-12">
                                <i class="bi bi-star-fill text-warning"></i>
                                4.5
                            </div>
                        </div>
                    </div>
                </div>

                <span class="badge badge-danger">{{ translate('Verification Failed') }}</span>
            </div>

            <div class="bg-light mt-3 rounded d-flex flex-wrap gap-2 p-3">
                <span class="badge badge-primary">{{ translate('mirpur_Zone') }}</span>
            </div>
        </div>
    </div>

    {{-- Surge Price Setup Offcanvas --}}
    <div class="offcanvas offcanvas-end" id="surge-price-offcanvas" style="--bs-offcanvas-width: 490px">
        <form action="#" class="d-flex flex-column h-100">
            <div class="offcanvas-header">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                <h4 class="offcanvas-title flex-grow-1 text-center">
                    {{ translate('Surge Price Setup') }}
                </h4>
            </div>
            <div class="offcanvas-body scrollbar-thin">
                <div class="mb-30">
                    <label class="form-label">
                        {{ translate('Setup Surge Pricing For') }}
                        <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                    </label>
                    <div class="d-flex align-items-center form-control">
                        <div class="flex-grow-1">
                            <input type="radio" name="pricing_for" value="ride" id="ride" checked="">
                            <label for="ride">{{ translate('ride') }}</label>
                        </div>

                        <div class="flex-grow-1">
                            <input type="radio" name="pricing_for" value="parcel" id="parcel">
                            <label for="parcel">{{ translate('parcel') }}</label>
                        </div>

                        <div class="flex-grow-1">
                            <input type="radio" name="pricing_for" value="both" id="both">
                            <label for="both">{{ translate('both') }}</label>
                        </div>
                    </div>
                </div>
                <div class="mb-30">
                    <label class="form-label">
                        {{ translate('name') }}
                        <span class="text-danger">*</span>
                    </label>
                    <input type="text" class="form-control" placeholder="{{ translate('type_Surge_Name') }}" required>
                </div>
                <div class="mb-30">
                    <label class="form-label">
                        {{ translate('zone') }}
                        <span class="text-danger">*</span>
                        <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                    </label>
                    <select class="js-select-multiple multiple-select2" name="states[]" multiple="multiple">
                        <option value="AL">Alabama</option>
                        <option value="WY">Wyoming</option>
                        <option value="BD">Bangladesh</option>
                        <option value="In">India</option>
                    </select>
                    {{-- <input type="text" class="form-control" placeholder="{{ translate('type_Surge_Name') }}" required> --}}
                </div>

                <div class="mb-30">
                    <label class="form-label">
                        {{ translate('Surge Price Schedule') }}
                        <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                    </label>
                    <div class="d-flex align-items-center form-control">
                        <div class="flex-grow-1">
                            <input type="radio" name="price_schedule" value="daily" id="daily" checked="">
                            <label for="daily">{{ translate('daily') }}</label>
                        </div>

                        <div class="flex-grow-1">
                            <input type="radio" name="price_schedule" value="weekly" id="weekly">
                            <label for="weekly">{{ translate('weekly') }}</label>
                        </div>

                        <div class="flex-grow-1">
                            <input type="radio" name="price_schedule" value="custom" id="custom">
                            <label for="custom">{{ translate('custom') }}</label>
                        </div>
                    </div>
                </div>

                <div class="bg-light mt-3 rounded p-3 mb-30">
                    <h4 class="mb-1">{{ translate('Select time & date') }}</h4>
                    <p class="fs-12">{{ translate('Select your suitable time within a time range you want add surge price') }}.</p>

                    <div class="mb-30">
                        <label class="form-label">
                            {{ translate('Date Range ') }}
                            <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                        </label>
                        <input type="date-range" class="form-control date-range-picker">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">
                            {{ translate('Date Range ') }}
                            <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                        </label>
                        <input type="date-range" class="form-control" placeholder="{{ translate('select_Days') }}" data-bs-toggle="modal" data-bs-target="#selectDaysModal">
                    </div>
                    <p class="fs-12 text-center mb-30">Every week from  <span class="text-success">24 sep, 2024</span> to <span class="text-success">30th oct, 2024</span></p>
                    <div class="mb-30">
                        <label class="form-label">
                            {{ translate('time Range ') }}
                            <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                        </label>
                        <input type="time" id="timeRangePicker" class="form-control">
                    </div>
                    <p class="text-center fs-12">{{ translate('This surge price will be applied for') }} <strong>{{ translate('10 time') }}.</strong></p>
                </div>

                <div class="bg-light mt-3 rounded p-3 mb-30">
                    <div class="mb-30">
                        <label class="form-label">
                            {{ translate('Price Increase Rate') }}
                            <i class="bi bi-info-circle-fill text-primary cursor-pointer" data-bs-toggle="tooltip" data-bs-title="{{ translate('need_content') }}"></i>
                        </label>
                        <div class="d-flex align-items-center form-control">
                            <div class="flex-grow-1">
                                <input type="radio" name="increase_rate" value="all_vehicle" id="all_vehicle" checked="">
                                <label for="all_vehicle">{{ translate('Same for All Vehicle') }}</label>
                            </div>

                            <div class="flex-grow-1">
                                <input type="radio" name="increase_rate" value="different_rate" id="different_rate">
                                <label for="different_rate">{{ translate('Setup Different Rate ') }}</label>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label class="form-label">
                            {{ translate('Rate') }}
                            <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="{{ translate('Ex: 20') }}">
                            <span class="input-group-text">%</span>
                        </div>
                    </div>
                </div>

                <div class="bg-light mt-3 rounded p-3 mb-30">
                    <div>
                        <h5 class="mb-1">{{ translate('Note for Customer') }}</h5>
                        <p class="fs-12">{{ translate('Add a note to inform users about temporary price changes.') }}</p>

                        <textarea name="note" id="note" rows="2" class="form-control" placeholder="{{ translate('Type note for customer') }}"></textarea>
                    </div>
                </div>

                <div class="bg-light mt-3 rounded p-3 mb-30">
                    <div class="d-flex justify-content-between gap-2 mb-3">
                        <div>
                            <h5 class="mb-1">{{ translate('Notify Driver') }}</h5>
                            <p class="fs-12">{{ translate('Enable alerts to inform drivers about surge zone') }}.</p>
                        </div>
                        <label class="switcher">
                            <input class="switcher_input status-change" type="checkbox" checked="">
                            <span class="switcher_control"></span>
                        </label>
                    </div>

                    <textarea name="notify" id="notify" rows="2" class="form-control" placeholder="{{ translate('Type notify driver') }}"></textarea>
                </div>

                <div class="mb-30">
                    <label class="form-label">{{ translate('Availability') }}</label>
                    <div class="d-flex align-items-center justify-content-between gap-2 form-control">
                        <div>{{ translate('Status') }}</div>
                        <label class="switcher">
                            <input class="switcher_input status-change" type="checkbox" checked="">
                            <span class="switcher_control"></span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="offcanvas-footer d-flex gap-3 bg-white shadow position-sticky bottom-0 p-3 justify-content-center">
                <button type="button" class="btn btn-light fw-semibold flex-grow-1"  data-bs-dismiss="offcanvas" aria-label="Close">
                    {{translate('cancel')}}</button>
                <button type="submit" class="btn btn-primary fw-semibold flex-grow-1">
                    {{translate('save') }}
                </button>
            </div>
        </form>
    </div>

    {{-- Filter Verification Request Offcanvas --}}
    <div class="offcanvas offcanvas-end" id="filter-verification-offcanvas" style="--bs-offcanvas-width: 490px">
        <form action="#" class="d-flex flex-column h-100">
            <div class="offcanvas-header">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                <h4 class="offcanvas-title flex-grow-1 text-center">
                    {{ translate('Filter Verification Request   ') }}
                </h4>
            </div>
            <div class="offcanvas-body scrollbar-thin">
                <div class="mb-30">
                    <div class="floating-form-group ">
                        <label for="" class="floating-form-label fs-12">
                            Verification Status
                        </label>
                        <select class="js-select btn btn-outline-primary form-control" name="">
                            <option value="">
                                {{translate("Failed")}}
                            </option>
                            <option value="">{{translate("Confirm")}}</option>
                            <option value="">{{translate("Pending")}}</option>
                        </select>
                    </div>
                </div>   
                <div class="mb-30">
                    <div class="floating-form-group mb-30">
                        <label for="" class="floating-form-label fs-12">
                            Select Date
                        </label>
                        <select class="js-select btn btn-outline-primary form-control" name="">
                            <option value="">
                                {{translate("All Time")}}
                            </option>
                            <option value="">
                                {{translate("Today")}}
                            </option>
                            <option value="">
                                {{translate("This Week")}}
                            </option>
                            <option value="">
                                {{translate("This Month")}}
                            </option>
                            <option value="">
                                {{translate("This Year")}}
                            </option>
                            <option value="">
                                {{translate("Custom date Range")}}
                            </option>
                        </select>
                    </div>
                    <div id="filterCustomDate" class="">
                        <div class="row">
                            <div class="col-6">
                                <div class="floating-form-group">
                                    <label class="floating-form-label fs-12">Start date</label>
                                    <input type="date" value="" id="start_date" name="start_date" class="form-control" required="required">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="floating-form-group">
                                    <label class="floating-form-label fs-12">End date</label>
                                    <input type="date" id="end_date" value="" name="end_date" class="form-control" required="required">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mb-30">
                     <h6 class="pb-2 border-bottom mb-3 fw-semibold">Sort By</h6>
                    <div class="d-flex flex-column gap-4">
                        <div class="custom__radio">
                            <label class="d-flex align-items-center justify-content-between">
                                <span class="radio-label fs-14">Default</span>
                                <input type="radio" name="sorting_by" class="position-relative" checked="">
                            </label>
                        </div>
                        <div class="custom__radio">
                            <label class="d-flex align-items-center justify-content-between">
                                <span class="radio-label fs-14">Oldest to Newest</span>
                                <input type="radio" name="sorting_by" class="position-relative">
                            </label>
                        </div>
                        <div class="custom__radio">
                            <label class="d-flex align-items-center justify-content-between">
                                <span class="radio-label fs-14">Newest to Oldest</span>
                                <input type="radio" name="sorting_by" class="position-relative">
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="offcanvas-footer d-flex gap-3 bg-white shadow position-sticky bottom-0 p-3 justify-content-center">                
                <button type="submit" class="btn btn-primary fw-semibold">
                    {{translate('Okay, Got It') }}
                </button>
            </div>
        </form>
    </div>

    {{-- How Verification Work Offcanvas --}}
    <div class="offcanvas offcanvas-end" id="howItWork-offcanvas" style="--bs-offcanvas-width: 490px">
        <form action="#" class="d-flex flex-column h-100">
            <div class="offcanvas-header">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                <h4 class="offcanvas-title flex-grow-1 text-center">
                    {{ translate('How Verification Work') }}
                </h4>
            </div>
            <div class="offcanvas-body scrollbar-thin">
                <div class="d-flex flex-column gap-20">
                    <div class="bg-fafafa rounded p-sm-4 p-3">
                        <h5 class="fw-medium mb-3">What is Driver Verification</h5>
                        <div class="bg-white rounded p-lg-3 p-3">
                            <ul class="fs-14 d-flex flex-column gap-2 mb-0 ps-18px">
                                <li>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                </li>
                                <li>
                                    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat
                                </li>
                                <li>
                                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur
                                </li>
                                <li>
                                    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                </li>
                            </ul>
                        </div>
                    </div> 
                    <div class="bg-fafafa rounded p-sm-4 p-3">
                        <h5 class="fw-medium mb-3">Why Driver Verification is Important</h5>
                        <div class="bg-white rounded p-lg-3 p-3">
                            <ul class="fs-14 d-flex flex-column gap-2 mb-0 ps-18px">
                                <li>
                                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                                </li>
                                <li>
                                    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                </li>
                            </ul>
                        </div>
                    </div> 
                    <div class="bg-fafafa rounded p-sm-4 p-3">
                        <h5 class="fw-medium mb-3">How Driver Verification Work</h5>
                        <div class="bg-white rounded p-lg-3 p-3">
                            <ul class="fs-14 d-flex flex-column gap-2 mb-0 ps-18px">
                                <li>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                </li>
                                <li>
                                    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                </li>
                            </ul>
                        </div>
                    </div> 
                </div>
            </div>
            <div class="offcanvas-footer d-flex gap-3 bg-white shadow position-sticky bottom-0 p-3 justify-content-center">                
                <button type="submit" class="btn btn-primary fw-semibold">
                    {{translate('Okay, Got It') }}
                </button>
            </div>
        </form>
    </div>
    



    <!-- Modal -->
    <div class="modal fade" id="selectDaysModal" tabindex="-1" aria-labelledby="selectDaysModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                {{-- <div class="modal-header">
                    <h5 class="modal-title" id="selectDaysModalLabel">Select Days</h5>
                </div> --}}
                <div class="modal-body">
                    <div class="d-flex justify-content-end">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="text-center mb-30">
                        <h3 class="mb-1">{{ translate('Select Days') }}</h3>
                        <p class="fs-12">{{ translate('Your Surge price active date ') }}</p>
                    </div>

                    <div class="bg-light mt-3 rounded p-3 mb-3">
                        <div class="d-flex flex-wrap column-gap-4 row-gap-2 user-select-none align-items-center">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="saturday" value="saturday" name="for_whom[]">
                                <label class="form-check-label" for="saturday">{{ translate('Saturday') }}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="sunday" value="sunday" name="for_whom[]">
                                <label class="form-check-label" for="sunday">{{ translate('Sunday') }}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="monday" value="monday" name="for_whom[]">
                                <label class="form-check-label" for="monday">{{ translate('monday') }}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="tuesday" value="tuesday" name="for_whom[]">
                                <label class="form-check-label" for="tuesday">{{ translate('tuesday') }}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="wednusday" value="wednusday" name="for_whom[]">
                                <label class="form-check-label" for="wednusday">{{ translate('wednusday') }}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="thursday" value="thursday" name="for_whom[]">
                                <label class="form-check-label" for="thursday">{{ translate('thursday') }}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="friday" value="friday" name="for_whom[]">
                                <label class="form-check-label" for="friday">{{ translate('friday') }}</label>
                            </div>
                        </div>
                    </div>

                    <div class="bg-light mt-3 rounded p-3 mb-3">
                        <h4 class="mb-1">{{ translate('Date Range') }}</h4>
                        <p class="fs-12">{{ translate('Select the date range you want to repeat this cycle every week') }}.</p>

                        <div class="mb-3">
                            <input type="date-range" class="form-control date-range-picker">
                        </div>

                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="assign" value="assign" name="assign[]">
                            <label class="form-check-label" for="assign">{{ translate('Assign this surge price permanently') }}</label>
                        </div>
                    </div>

                    <div class="d-flex gap-3 justify-content-end flex-wrap">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">{{ translate('cencel') }}</button>
                        <button type="button" class="btn btn-primary">{{ translate('save') }}</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script')
    <script type="text/javascript" src="{{asset('public/assets/admin-module/plugins/daterangepicker/moment.min.js')}}"></script>
    <script src="{{asset('public/assets/admin-module/plugins/daterangepicker/daterangepicker.min.js')}}"></script>
    <script src="{{asset('public/assets/admin-module/js/date-range-picker.js')}}"></script>
    <script>
        "use strict";

        $(document).ready(function() {
            $('.js-select-multiple').select2({
                placeholder: "Select Zone... "
            });
        });
    </script>
@endpush
