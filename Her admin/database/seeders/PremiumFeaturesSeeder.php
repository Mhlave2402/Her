<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PremiumFeaturesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('feature_fee_configs')->insert([
            [
                'feature_key' => 'baby_seat',
                'display_name' => 'Baby Seat',
                'icon' => 'baby_seat_icon.png',
                'value' => 15.00,
                'pricing_model' => 'flat',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'feature_key' => 'extra_luggage',
                'display_name' => 'Extra Luggage',
                'icon' => 'extra_luggage_icon.png',
                'value' => 25.00,
                'pricing_model' => 'flat',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'feature_key' => 'pet_friendly',
                'display_name' => 'Pet Friendly',
                'icon' => 'pet_friendly_icon.png',
                'value' => 20.00,
                'pricing_model' => 'flat',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
