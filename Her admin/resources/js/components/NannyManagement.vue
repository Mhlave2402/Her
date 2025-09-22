<template>
  <div>
    <h2>Nanny Management</h2>
    <table class="table">
      <thead>
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th>Verified</th>
          <th>Service Fee</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="nanny in nannies" :key="nanny.id">
          <td>{{ nanny.first_name }} {{ nanny.last_name }}</td>
          <td>{{ nanny.email }}</td>
          <td>
            <input type="checkbox" :checked="nanny.is_kids_only_verified" @change="verifyNanny(nanny.id, $event.target.checked)">
          </td>
          <td>
            <input type="number" v-model="nanny.nanny_service_fee" @change="setFee(nanny.id, nanny.nanny_service_fee)">
          </td>
          <td>
            <button class="btn btn-primary" @click="saveChanges(nanny)">Save</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      nannies: [],
    };
  },
  created() {
    this.fetchNannies();
  },
  methods: {
    fetchNannies() {
      axios.get('/api/nannies')
        .then(response => {
          this.nannies = response.data;
        })
        .catch(error => {
          console.error(error);
        });
    },
    verifyNanny(id, isVerified) {
      axios.put(`/api/nannies/${id}/verify`, { is_verified: isVerified })
        .then(response => {
          // handle success
        })
        .catch(error => {
          console.error(error);
        });
    },
    setFee(id, fee) {
      axios.put(`/api/nannies/${id}/fee`, { fee: fee })
        .then(response => {
          // handle success
        })
        .catch(error => {
          console.error(error);
        });
    },
    saveChanges(nanny) {
        this.verifyNanny(nanny.id, nanny.is_kids_only_verified);
        this.setFee(nanny.id, nanny.nanny_service_fee);
    }
  },
};
</script>
