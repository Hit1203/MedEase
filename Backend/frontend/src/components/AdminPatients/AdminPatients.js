import React, { Component } from 'react'
import ClipLoader from 'react-spinners/ClipLoader'
import { fetchRequest } from '../../../helpers/fetchRequest'
import styles from './AdminPatients.module.css'
import Patients from './Patients'
const parseCookie = (str) =>
  str
    .split(';')
    .map((v) => v.split('='))
    .reduce((acc, v) => {
      acc[decodeURIComponent(v[0].trim())] = decodeURIComponent(v[1].trim())
      return acc
    }, {})

let pp = {
  patients: [
    {
      custom_id: 'EZBUHEKWESKBIDJJDERC',
      fullname: 'Mihir Patel',
      age: '20',
      gender: 'Male',
      weight: '82',
      height: '1.86',
      blood_group: 'B+',
    },
    {
      custom_id: 'EZBUHEKWESKBIDJJDERC',
      fullname: 'Mihir Patel',
      age: '20',
      gender: 'Male',
      weight: '82',
      height: '1.86',
      blood_group: 'B+',
    },
  ],
}

export default class AdminPatients extends Component {
  constructor(props) {
    super(props)
    this.state = { patients: [], reload: true, isLoading: true }
  }

  refresh = () => {
    this.setState({ reload: !this.state.reload })
    fetchRequest({
      path_: '/admin-get-all-patients/',
      method: 'POST',
      body: {
        jwt: parseCookie(document.cookie).token,
      },
      next: (data) => {
        let patients = data.responseData.patients
        this.setState({ patients: patients, isLoading: false })
      },
    })
  }

  loadPatients = () => {
    fetchRequest({
      path_: '/admin-get-all-patients/',
      method: 'POST',
      body: {
        jwt: parseCookie(document.cookie).token,
      },
      next: (data) => {
        let patients = data.responseData.patients
        this.setState({ patients: patients, isLoading: false })
      },
    })
  }

  componentWillMount() {
    this.loadPatients()
  }

  componentDidUpdate() {}

  render() {
    return this.state.isLoading ? (
      <div
        className={styles.coverIt}
        style={{
          justifySelf: 'center',
          alignSelf: 'center',
          marginTop: '30px',
        }}
      >
        <ClipLoader
          color={'blue'}
          loading={true}
          size={100}
          aria-label="Loading Spinner"
          data-testid="loader"
        />
      </div>
    ) : (
      <div className={styles.coverIt}>
        {this.state.patients ? (
          this.state.patients.map((doctor, i) => (
            <Patients
              fullname={doctor.fullname}
              custom_id={doctor.custom_id}
              gender={doctor.gender}
              age={doctor.age}
              height={doctor.height}
              weight={doctor.weight}
              blood_group={doctor.blood_group}
              reload={this.refresh}
              key={i}
            />
          ))
        ) : (
          <></>
        )}
      </div>
    )
  }
}
