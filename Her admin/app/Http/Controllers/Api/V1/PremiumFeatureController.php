<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PremiumFeatureController extends Controller
{
    public function index()
    {
        $features = DB::table('feature_fee_configs')
            ->select(
                'id',
                'display_name as name',
                DB::raw("CONCAT('/storage/app/public/feature/', icon) as icon_url"),
                'value as surcharge_amount'
            )
            ->get();

        return response()->json($features);
    }
}
