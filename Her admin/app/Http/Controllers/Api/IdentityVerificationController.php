<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class IdentityVerificationController extends Controller
{
    public function upload(Request $request)
    {
        $request->validate([
            'id_document' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'selfie' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $user = Auth::user();

        $idDocumentPath = $request->file('id_document')->store('id_documents', 'public');
        $selfiePath = $request->file('selfie')->store('selfies', 'public');

        $user->identification_image = $idDocumentPath;
        $user->selfie_image = $selfiePath;
        $user->save();

        // Step 1: Call a third-party Identity Verification Service
        // You would need to sign up for a service (e.g., Smile Identity, Onfido)
        // and use their SDK or an HTTP client to make the API call.
        // This is a simulated example.
        $verificationResult = $this->verifyWithHomeAffairs($user->identification_number, $selfiePath);

        // Step 2: Update user status based on the result
        if ($verificationResult['status'] === 'success') {
            $user->is_verified = true;
            $user->save();
            return response()->json(['message' => 'Verification successful.']);
        } else {
            // Optionally, log the reason for failure
            return response()->json(['message' => 'Verification failed: ' . $verificationResult['reason']], 400);
        }
    }

    /**
     * Simulate a call to a third-party IDV service.
     * In a real application, this would involve an HTTP request to the service's API endpoint.
     *
     * @param string $idNumber
     * @param string $selfiePath
     * @return array
     */
    private function verifyWithHomeAffairs(string $idNumber, string $selfiePath): array
    {
        // --- REAL IMPLEMENTATION WOULD GO HERE ---
        // $apiKey = config('services.idv.api_key');
        // $client = new \GuzzleHttp\Client();
        // $response = $client->post('https://api.idvservice.com/v1/verify', [
        //     'headers' => ['Authorization' => 'Bearer ' . $apiKey],
        //     'form_params' => [
        //         'id_number' => $idNumber,
        //         'selfie_image' => Storage::disk('public')->get($selfiePath)
        //     ]
        // ]);
        // $result = json_decode($response->getBody(), true);
        // return $result;
        // --- END OF REAL IMPLEMENTATION ---

        // For demonstration purposes, we'll simulate a successful response.
        // To test a failure, you can change 'status' to 'failed'.
        if (empty($idNumber)) {
            return ['status' => 'failed', 'reason' => 'ID number not provided.'];
        }

        return ['status' => 'success', 'reason' => 'ID number and selfie match.'];
    }

    public function status()
    {
        $user = Auth::user();

        return response()->json(['is_verified' => $user->is_verified]);
    }
}
