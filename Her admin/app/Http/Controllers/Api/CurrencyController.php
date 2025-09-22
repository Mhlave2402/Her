<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Modules\ZoneManagement\Entities\Zone;
use Modules\ZoneManagement\Repository\ZoneRepositoryInterface;
use Illuminate\Support\Facades\DB;

class CurrencyController extends Controller
{
    protected $zoneRepository;

    public function __construct(ZoneRepositoryInterface $zoneRepository)
    {
        $this->zoneRepository = $zoneRepository;
    }

    public function getCurrencyByLocation(Request $request)
    {
        $request->validate([
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
            'type' => 'required|in:user,driver'
        ]);

        $latitude = $request->latitude;
        $longitude = $request->longitude;
        $type = $request->type;

        // Find zone containing the coordinates
        $zone = $this->findZoneByCoordinates($latitude, $longitude);

        // Get currency info
        $currencyCode = $zone->currency_code ?? 'ZAR';
        $currencySymbol = $zone->currency_symbol ?? 'R';
        $exchangeRate = $zone->exchange_rate ?? 1.0;

        return response()->json([
            'currencyCode' => $currencyCode,
            'currencySymbol' => $currencySymbol,
            'exchangeRate' => $exchangeRate,
            'zoneId' => $zone->id ?? null,
            'zoneName' => $zone->name ?? 'Default Zone',
            'appType' => $type
        ]);
    }

    private function findZoneByCoordinates($latitude, $longitude)
    {
        return Zone::where('is_active', 1)
            ->whereRaw("ST_Contains(area, POINT(?, ?))", [$longitude, $latitude])
            ->first();
    }
}
