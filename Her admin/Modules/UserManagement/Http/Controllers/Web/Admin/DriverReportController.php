<?php

namespace Modules\UserManagement\Http\Controllers\Web\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\DriverReport;

class DriverReportController extends Controller
{
    public function index(Request $request)
    {
        $reports = DriverReport::with(['driver', 'user'])->latest()->paginate(10);
        return view('usermanagement::admin.driver.report', compact('reports'));
    }
}
