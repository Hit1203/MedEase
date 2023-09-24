import { faTrash } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import React, { Component } from 'react'
import { fetchRequest } from '../../../helpers/fetchRequest'
import styles from './Appointments.module.css'

const parseCookie = (str) =>
  str
    .split(';')
    .map((v) => v.split('='))
    .reduce((acc, v) => {
      acc[decodeURIComponent(v[0].trim())] = decodeURIComponent(v[1].trim())
      return acc
    }, {})

export default class Appointments extends Component {
  constructor(props) {
    super(props)
    this.handleDelete = this.delete__.bind(this)
  }

  delete__(event) {
    fetchRequest({
      path_: '/admin-delete-appointment/',
      method: 'POST',
      body: {
        jwt: parseCookie(document.cookie).token,
        custom_id: this.props.custom_id,
      },
      next: (data) => {
        if (data.responseData.authorized && data.responseData.deleted) {
          this.props.reload()
        }
      },
    })
  }

  render() {
    return (
      <div className={styles.container}>
        <div className={styles.logo}>
          <h4>{this.props.slot}</h4>
        </div>
        <div className={styles.midPanel}>
          <div className={styles.top}>
            <p style={{ margin: '0px' }} className={styles.para}>
              {this.props.doctor_name}
            </p>{' '}
            <p style={{ margin: '0px' }} className={styles.para}>
              {this.props.patient_name}
            </p>{' '}
          </div>
          <div className={styles.bottom}>
            <p
              style={{ margin: '0px', fontSize: '10px' }}
              className={styles.date}
            >
              Date : {this.props.time.split(' ')[0]}
            </p>{' '}
            <p
              style={{ margin: '0px', fontSize: '10px' }}
              className={styles.date}
            >
              Time : {this.props.time.split(' ')[1]}
            </p>
          </div>
        </div>
        <div className={styles.delContainer}>
          <FontAwesomeIcon
            icon={faTrash}
            onClick={this.handleDelete}
            className={styles.hover}
          />
        </div>
      </div>
    )
  }
}
