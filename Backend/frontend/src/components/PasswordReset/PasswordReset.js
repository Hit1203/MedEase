import React, { Component } from 'react'
import { fetchRequest } from '../../../helpers/fetchRequest'
import styles from './PasswordReset.module.css'

export class PasswordReset extends Component {
  constructor(props) {
    console.log(props)
    let pn = window.location.pathname.substring(
      0,
      window.location.pathname.length - 1,
    )
    let index = pn.lastIndexOf('/') + 1
    super(props)
    this.state = {
      token: pn.substring(index, pn.length),
      password: '',
      confirmPassword: '',
      passwordMatch: true,
    }
    this.handlePasswordChange = this.onPasswordChange.bind(this)
    this.handleConfirmPasswordChange = this.onConfirmPasswordChange.bind(this)
    this.handleSubmit = this.onSubmit.bind(this)
  }

  onPasswordChange(event) {
    this.setState({
      password: event.target.value,
    })
    this.setState({
      passwordMatch: event.target.value === this.state.confirmPassword,
    })
  }

  onConfirmPasswordChange(event) {
    this.setState(
      {
        confirmPassword: event.target.value,
      },
      () => {},
    )
    this.setState({
      passwordMatch: this.state.password === event.target.value,
    })
  }

  onSubmit(event) {
    event.preventDefault()
    if (this.state.passwordMatch) {
      fetchRequest({
        path_: window.location,
        method: 'POST',
        body: {
          newPassword: this.state.password,
        },
        next: (data) => {
          console.log(data)
          if (data['responseData']['validToken']) {
            alert('Your password has been reset successfully!')
          } else {
            alert('Password has not been reset!')
          }
        },
      })
    }
  }

  render() {
    return (
      <>
        <div className={styles.whole}>
          <div className={styles.menu}>
            <div className={styles.logo}>
              <img src="/static/frontend/logo.jpg" className={styles.logoimg} />
            </div>
            <div className={styles.name}>
              <h3>MedEase</h3>
              <h7>Reset your password</h7>
            </div>
            <div className={styles.main}>
              <div className={styles.inputs}>
                <input
                  type="password"
                  id="password"
                  placeholder="Password"
                  onChange={this.handlePasswordChange}
                  value={this.state.password}
                />
                <input
                  type="password"
                  id="cPassword"
                  placeholder="Confirm Password"
                  onChange={this.handleConfirmPasswordChange}
                  value={this.state.confirmPassword}
                  style={{ marginBottom: '0px', marginTop: '30px' }}
                />
                <label
                  id="label"
                  style={{
                    color: 'red',
                    marginTop: '-5px',
                    width: '70%',
                    height: '25px',
                    // display: this.state.passwordMatch ? 'hidden' : 'block',
                  }}
                >
                  {this.state.passwordMatch ? '' : 'Passwords do not match.'}
                </label>
                {}
              </div>
              <div className={styles.submit}>
                <div
                  className={styles.button}
                  onClick={this.handleSubmit}
                  style={{
                    background: this.state.passwordMatch ? 'white' : 'gray',
                    color: this.state.passwordMatch ? 'black' : 'white',
                  }}
                >
                  Submit
                </div>
              </div>
              <div className={styles.container}></div>
            </div>
          </div>
        </div>
      </>
    )
  }
}

export default PasswordReset
