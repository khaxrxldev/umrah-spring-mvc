package com.umrah.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "umrah_agency")
public class AgencyEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "agency_id")
	private String agencyId;
	
	@Column(name = "agency_name")
	private String agencyName;
	
	@Column(name = "agency_email")
	private String agencyEmail;
	
	@Column(name = "agency_phone_num")
	private String agencyPhoneNum;
	
	@Column(name = "agency_adress")
	private String agencyAddress;
	
	@Column(name = "agency_website")
	private String agencyWebsite;
	
	@Column(name = "agency_license_number")
	private String agencyLicenseNumber;
	
	@Column(name = "admin_id")
	private String adminId;

	public String getAgencyId() {
		return agencyId;
	}

	public void setAgencyId(String agencyId) {
		this.agencyId = agencyId;
	}

	public String getAgencyName() {
		return agencyName;
	}

	public void setAgencyName(String agencyName) {
		this.agencyName = agencyName;
	}

	public String getAgencyEmail() {
		return agencyEmail;
	}

	public void setAgencyEmail(String agencyEmail) {
		this.agencyEmail = agencyEmail;
	}

	public String getAgencyPhoneNum() {
		return agencyPhoneNum;
	}

	public void setAgencyPhoneNum(String agencyPhoneNum) {
		this.agencyPhoneNum = agencyPhoneNum;
	}

	public String getAgencyAddress() {
		return agencyAddress;
	}

	public void setAgencyAddress(String agencyAddress) {
		this.agencyAddress = agencyAddress;
	}

	public String getAgencyWebsite() {
		return agencyWebsite;
	}

	public void setAgencyWebsite(String agencyWebsite) {
		this.agencyWebsite = agencyWebsite;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getAgencyLicenseNumber() {
		return agencyLicenseNumber;
	}

	public void setAgencyLicenseNumber(String agencyLicenseNumber) {
		this.agencyLicenseNumber = agencyLicenseNumber;
	}
}
