<?php

namespace Modules\UserManagement\Http\Controllers\Web\Admin;

use App\Http\Controllers\Controller;
use App\Models\DriverBehavior;
use Illuminate\Http\Request;
use Modules\UserManagement\Interfaces\DriverInterface;

class DriverBehaviorController extends Controller
{
    protected $driver;

    public function __construct(DriverInterface $driver)
    {
        $this->driver = $driver;
    }

    public function index(Request $request)
    {
        $request->validate([
            'type' => 'in:all,speeding,hard_braking',
        ]);

        $query = DriverBehavior::with('driver');

        if ($request->has('type') && $request->type != 'all') {
            $query->where('type', $request->type);
        }

        $behaviors = $query->latest()->paginate(10);

        return view('usermanagement::admin.driver.behavior', compact('behaviors'));
    }
}
