import { faTrash } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import React, { Component } from 'react'
import { fetchRequest } from '../../../helpers/fetchRequest'
import styles from './Patients.module.css'

const parseCookie = (str) =>
  str
    .split(';')
    .map((v) => v.split('='))
    .reduce((acc, v) => {
      acc[decodeURIComponent(v[0].trim())] = decodeURIComponent(v[1].trim())
      return acc
    }, {})

export default class Patients extends Component {
  constructor(props) {
    super(props)
    this.state = {}
    this.handleDelete = this.delete__.bind(this)
  }

  delete__(event) {
    
    fetchRequest({
      path_: '/delete-user/',
      method: 'POST',
      body: {
        jwt: parseCookie(document.cookie).token,
        custom_id: this.props.custom_id,
      },
      next: (data) => {
        if (
          data['responseData']['authorized'] &&
          data['responseData']['deleted']
        ) {
          this.props.reload()
        }
      },
    })
  }
  render() {
    return (
      <div className={styles.container}>
        <div className={styles.logo}>
          <img
            className={styles.logoimg}
            src={
              this.props.gender == 'Male'
                ? '/static/frontend/malePAT.jpg'
                : '/static/frontend/femalePAT.jpg'
            }
          />
        </div>
        <div className={styles.midPanel}>
          <div className={styles.top}>
            <p style={{ margin: '0px' }}>
              {this.props.gender == 'Male' ? 'Mr. ' : 'Mrs .'}{' '}
              {this.props.fullname}
            </p>{' '}
            <p style={{ margin: '0px' }}>{this.props.age}</p>
          </div>
          <div className={styles.bottom}>
            <p style={{ margin: '0px', fontSize: '10px' }}>
              Height : {this.props.height}
            </p>{' '}
            <p style={{ margin: '0px', fontSize: '10px' }}>
              Weight : {this.props.weight}
            </p>
            <p style={{ margin: '0px', fontSize: '10px' }}>
              Blood Group : {this.props.blood_group}
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
