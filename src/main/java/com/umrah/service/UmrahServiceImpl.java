package com.umrah.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.umrah.dao.AdminRepository;
import com.umrah.dao.AgencyRepository;
import com.umrah.dao.FilterRepository;
import com.umrah.dto.AdminRequest;
import com.umrah.dto.AdminResponse;
import com.umrah.dto.AgencyRequest;
import com.umrah.dto.AgencyResponse;
import com.umrah.dto.FilterRequest;
import com.umrah.dto.FilterResponse;
import com.umrah.dto.LoginRequest;
import com.umrah.dto.LoginResponse;
import com.umrah.entity.AdminEntity;
import com.umrah.entity.AgencyEntity;
import com.umrah.entity.FilterEntity;
import com.umrah.utility.BaseUtility;

import jakarta.transaction.Transactional;

@Service
public class UmrahServiceImpl implements UmrahService {

	@Autowired
	AdminRepository adminRepository;

	@Autowired
	AgencyRepository agencyRepository;

	@Autowired
	FilterRepository filterRepository;
	
	@Override
	public List<AdminResponse> getAdmins() {
		List<AdminResponse> adminResponses = new ArrayList<>();
		List<AdminEntity> adminEntities = adminRepository.findAll();
		
		for (AdminEntity adminEntity : adminEntities) {
			AdminResponse adminResponse = new AdminResponse();
			
			adminResponse.setAdminId(adminEntity.getAdminId());
			adminResponse.setAdminName(adminEntity.getAdminName());
			adminResponse.setAdminEmail(adminEntity.getAdminEmail());
			adminResponse.setAdminGender(adminEntity.getAdminGender());
			adminResponse.setAdminPassword(adminEntity.getAdminPassword());
			adminResponse.setAdminType(adminEntity.getAdminType());
			adminResponse.setAdminStatus(adminEntity.getAdminStatus());
			
			AgencyResponse agencyResponse = getAgencyByAdminId(adminEntity.getAdminId());
			if (BaseUtility.isObjectNotNull(agencyResponse)) {
				adminResponse.setAgency(agencyResponse);
			}
			
			adminResponses.add(adminResponse);
		}
		
		return adminResponses;
	}

	@Override
	public AdminResponse getAdminByAdminId(String adminId) {
		AdminResponse adminResponse = new AdminResponse();
		AdminEntity adminEntity = adminRepository.findByAdminId(adminId);
		
		if (BaseUtility.isObjectNotNull(adminEntity)) {
			adminResponse.setAdminId(adminEntity.getAdminId());
			adminResponse.setAdminName(adminEntity.getAdminName());
			adminResponse.setAdminEmail(adminEntity.getAdminEmail());
			adminResponse.setAdminGender(adminEntity.getAdminGender());
			adminResponse.setAdminPassword(adminEntity.getAdminPassword());
			adminResponse.setAdminType(adminEntity.getAdminType());
			adminResponse.setAdminStatus(adminEntity.getAdminStatus());
		}
		
		return adminResponse;
	}

	@Override
	public LoginResponse adminLogin(LoginRequest loginRequest) {
		LoginResponse loginResponse = new LoginResponse();
		AdminEntity adminEntity = adminRepository.findByAdminEmail(loginRequest.getLoginUsername());
		
		if (BaseUtility.isObjectNotNull(adminEntity)) {
			if (adminEntity.getAdminStatus().equals("APPROVED")) {
				if (adminEntity.getAdminPassword().equals(loginRequest.getLoginPassword())) {
					loginResponse.setLoginId(adminEntity.getAdminId());
					loginResponse.setLoginType(adminEntity.getAdminType());
					loginResponse.setLoginStatus(true);
					loginResponse.setLoginMessage("Login successfully.");
				} else {
					loginResponse.setLoginStatus(false);
					loginResponse.setLoginError("Wrong password entered.");
				}
			} else {
				loginResponse.setLoginStatus(false);
				loginResponse.setLoginError("Profile has not been approved.");
			}
		} else {
			loginResponse.setLoginStatus(false);
			loginResponse.setLoginError("Email is not registered.");
		}
		
		return loginResponse;
	}

	@Override
	public AdminResponse insertAdmin(AdminRequest adminRequest) {
		AdminResponse adminResponse = new AdminResponse();
		AdminEntity newAdminEntity = new AdminEntity();
		
		newAdminEntity.setAdminId(BaseUtility.generateId());
		newAdminEntity.setAdminName(adminRequest.getAdminName());
		newAdminEntity.setAdminEmail(adminRequest.getAdminEmail());
		newAdminEntity.setAdminGender(adminRequest.getAdminGender());
		newAdminEntity.setAdminPassword(adminRequest.getAdminPassword());
		newAdminEntity.setAdminType("ADMIN");
		newAdminEntity.setAdminStatus("PENDING");
		
		AdminEntity insertedAdminEntity = adminRepository.save(newAdminEntity);
		
		if (BaseUtility.isObjectNotNull(insertedAdminEntity)) {
			adminResponse.setAdminId(insertedAdminEntity.getAdminId());
			adminResponse.setAdminName(insertedAdminEntity.getAdminName());
			adminResponse.setAdminEmail(insertedAdminEntity.getAdminEmail());
			adminResponse.setAdminGender(insertedAdminEntity.getAdminGender());
			adminResponse.setAdminPassword(insertedAdminEntity.getAdminPassword());
			adminResponse.setAdminType(insertedAdminEntity.getAdminType());
			adminResponse.setAdminStatus(insertedAdminEntity.getAdminStatus());
		}
		
		return adminResponse;
	}

	@Override
	public AdminResponse updateAdmin(AdminRequest adminRequest) {
		AdminResponse adminResponse = new AdminResponse();
		AdminEntity existedAdminEntity = adminRepository.findByAdminId(adminRequest.getAdminId());
		
		if (BaseUtility.isNotBlank(adminRequest.getAdminName())) {
			existedAdminEntity.setAdminName(adminRequest.getAdminName());
		}
		if (BaseUtility.isNotBlank(adminRequest.getAdminEmail())) {
			existedAdminEntity.setAdminEmail(adminRequest.getAdminEmail());
		}
		if (BaseUtility.isNotBlank(adminRequest.getAdminGender())) {
			existedAdminEntity.setAdminGender(adminRequest.getAdminGender());
		}
		if (BaseUtility.isNotBlank(adminRequest.getAdminPassword())) {
			existedAdminEntity.setAdminPassword(adminRequest.getAdminPassword());
		}
		if (BaseUtility.isNotBlank(adminRequest.getAdminType())) {
			existedAdminEntity.setAdminType(adminRequest.getAdminType());
		}
		if (BaseUtility.isNotBlank(adminRequest.getAdminStatus())) {
			existedAdminEntity.setAdminStatus(adminRequest.getAdminStatus());
		}
		
		AdminEntity updatedAdminEntity = adminRepository.save(existedAdminEntity);
		
		if (BaseUtility.isObjectNotNull(updatedAdminEntity)) {
			adminResponse.setAdminId(updatedAdminEntity.getAdminId());
			adminResponse.setAdminName(updatedAdminEntity.getAdminName());
			adminResponse.setAdminEmail(updatedAdminEntity.getAdminEmail());
			adminResponse.setAdminGender(updatedAdminEntity.getAdminGender());
			adminResponse.setAdminPassword(updatedAdminEntity.getAdminPassword());
			adminResponse.setAdminType(updatedAdminEntity.getAdminType());
			adminResponse.setAdminStatus(updatedAdminEntity.getAdminStatus());
		}
		
		return adminResponse;
	}

	@Transactional
	public Boolean deleteAdminByAdminId(String adminId) {
		Integer totalDeleted = 0;
		
		try {
			totalDeleted = adminRepository.deleteByAdminId(adminId);
		} catch (Exception exception) {
			System.out.println(exception.getMessage());
		}
		
		if (totalDeleted > 0) {
			return true;
		}
		
		return false;
	}

	@Override
	public List<AgencyResponse> getAgencies() {
		List<AgencyResponse> agencyResponses = new ArrayList<>();
		List<AgencyEntity> agencyEntities = agencyRepository.findAll();
		
		for (AgencyEntity agencyEntity : agencyEntities) {
			AgencyResponse agencyResponse = new AgencyResponse();
			
			agencyResponse.setAgencyId(agencyEntity.getAgencyId());
			agencyResponse.setAgencyName(agencyEntity.getAgencyName());
			agencyResponse.setAgencyEmail(agencyEntity.getAgencyEmail());
			agencyResponse.setAgencyPhoneNum(agencyEntity.getAgencyPhoneNum());
			agencyResponse.setAgencyAddress(agencyEntity.getAgencyAddress());
			agencyResponse.setAgencyWebsite(agencyEntity.getAgencyWebsite());
			agencyResponse.setAdminId(agencyEntity.getAdminId());
			agencyResponse.setAgencyLicenseNumber(agencyEntity.getAgencyLicenseNumber());
			
			agencyResponses.add(agencyResponse);
		}
		
		return agencyResponses;
	}

	@Override
	public AgencyResponse getAgencyByAgencyId(String agencyId) {
		AgencyResponse agencyResponse = new AgencyResponse();
		AgencyEntity agencyEntity = agencyRepository.findByAgencyId(agencyId);
		
		if (BaseUtility.isObjectNotNull(agencyEntity)) {
			agencyResponse.setAgencyId(agencyEntity.getAgencyId());
			agencyResponse.setAgencyName(agencyEntity.getAgencyName());
			agencyResponse.setAgencyEmail(agencyEntity.getAgencyEmail());
			agencyResponse.setAgencyPhoneNum(agencyEntity.getAgencyPhoneNum());
			agencyResponse.setAgencyAddress(agencyEntity.getAgencyAddress());
			agencyResponse.setAgencyWebsite(agencyEntity.getAgencyWebsite());
			agencyResponse.setAdminId(agencyEntity.getAdminId());
			agencyResponse.setAgencyLicenseNumber(agencyEntity.getAgencyLicenseNumber());
		}
		
		return agencyResponse;
	}

	@Override
	public AgencyResponse getAgencyByAdminId(String adminId) {
		AgencyResponse agencyResponse = new AgencyResponse();
		AgencyEntity agencyEntity = agencyRepository.findByAdminId(adminId);
		
		if (BaseUtility.isObjectNotNull(agencyEntity)) {
			agencyResponse.setAgencyId(agencyEntity.getAgencyId());
			agencyResponse.setAgencyName(agencyEntity.getAgencyName());
			agencyResponse.setAgencyEmail(agencyEntity.getAgencyEmail());
			agencyResponse.setAgencyPhoneNum(agencyEntity.getAgencyPhoneNum());
			agencyResponse.setAgencyAddress(agencyEntity.getAgencyAddress());
			agencyResponse.setAgencyWebsite(agencyEntity.getAgencyWebsite());
			agencyResponse.setAdminId(agencyEntity.getAdminId());
			agencyResponse.setAgencyLicenseNumber(agencyEntity.getAgencyLicenseNumber());
		}
		
		return agencyResponse;
	}

	@Override
	public AgencyResponse insertAgency(AgencyRequest agencyRequest) {
		AgencyResponse agencyResponse = new AgencyResponse();
		AgencyEntity newAgencyEntity = new AgencyEntity();
		
		newAgencyEntity.setAgencyId(BaseUtility.generateId());
		newAgencyEntity.setAgencyName(agencyRequest.getAgencyName());
		newAgencyEntity.setAgencyEmail(agencyRequest.getAgencyEmail());
		newAgencyEntity.setAgencyPhoneNum(agencyRequest.getAgencyPhoneNum());
		newAgencyEntity.setAgencyAddress(agencyRequest.getAgencyAddress());
		newAgencyEntity.setAgencyWebsite(agencyRequest.getAgencyWebsite());
		newAgencyEntity.setAdminId(agencyRequest.getAdminId());
		newAgencyEntity.setAgencyLicenseNumber(agencyRequest.getAgencyLicenseNumber());
		
		AgencyEntity insertedAgencyEntity = agencyRepository.save(newAgencyEntity);
		
		if (BaseUtility.isObjectNotNull(insertedAgencyEntity)) {
			agencyResponse.setAgencyId(insertedAgencyEntity.getAgencyId());
			agencyResponse.setAgencyName(insertedAgencyEntity.getAgencyName());
			agencyResponse.setAgencyEmail(insertedAgencyEntity.getAgencyEmail());
			agencyResponse.setAgencyPhoneNum(insertedAgencyEntity.getAgencyPhoneNum());
			agencyResponse.setAgencyAddress(insertedAgencyEntity.getAgencyAddress());
			agencyResponse.setAgencyWebsite(insertedAgencyEntity.getAgencyWebsite());
			agencyResponse.setAdminId(insertedAgencyEntity.getAdminId());
			agencyResponse.setAgencyLicenseNumber(insertedAgencyEntity.getAgencyLicenseNumber());
		}
		
		return agencyResponse;
	}

	@Override
	public AgencyResponse updateAgency(AgencyRequest agencyRequest) {
		AgencyResponse agencyResponse = new AgencyResponse();
		AgencyEntity existedAgencyEntity = agencyRepository.findByAgencyId(agencyRequest.getAgencyId());

		existedAgencyEntity.setAgencyName(agencyRequest.getAgencyName());
		existedAgencyEntity.setAgencyEmail(agencyRequest.getAgencyEmail());
		existedAgencyEntity.setAgencyPhoneNum(agencyRequest.getAgencyPhoneNum());
		existedAgencyEntity.setAgencyAddress(agencyRequest.getAgencyAddress());
		existedAgencyEntity.setAgencyWebsite(agencyRequest.getAgencyWebsite());
		existedAgencyEntity.setAdminId(agencyRequest.getAdminId());
		existedAgencyEntity.setAgencyLicenseNumber(agencyRequest.getAgencyLicenseNumber());
		
		AgencyEntity updatedAgencyEntity = agencyRepository.save(existedAgencyEntity);
		
		if (BaseUtility.isObjectNotNull(updatedAgencyEntity)) {
			agencyResponse.setAgencyId(updatedAgencyEntity.getAgencyId());
			agencyResponse.setAgencyName(updatedAgencyEntity.getAgencyName());
			agencyResponse.setAgencyEmail(updatedAgencyEntity.getAgencyEmail());
			agencyResponse.setAgencyPhoneNum(updatedAgencyEntity.getAgencyPhoneNum());
			agencyResponse.setAgencyAddress(updatedAgencyEntity.getAgencyAddress());
			agencyResponse.setAgencyWebsite(updatedAgencyEntity.getAgencyWebsite());
			agencyResponse.setAdminId(updatedAgencyEntity.getAdminId());
			agencyResponse.setAgencyLicenseNumber(updatedAgencyEntity.getAgencyLicenseNumber());
		}
		
		return agencyResponse;
	}

	@Transactional
	public Boolean deleteAgencyByAgencyId(String agencyId) {
		Integer totalDeleted = 0;
		
		try {
			totalDeleted = agencyRepository.deleteByAgencyId(agencyId);
		} catch (Exception exception) {
			System.out.println(exception.getMessage());
		}
		
		if (totalDeleted > 0) {
			return true;
		}
		
		return false;
	}

	@Override
	public List<FilterResponse> getFilters() {
		List<FilterResponse> filterResponses = new ArrayList<>();
		List<FilterEntity> filterEntities = filterRepository.findAll();
		
		for (FilterEntity filterEntity : filterEntities) {
			FilterResponse filterResponse = new FilterResponse();
			
			filterResponse.setFilterId(filterEntity.getFilterId());
			filterResponse.setFilterStartPriceStatus(filterEntity.getFilterStartPriceStatus());
			filterResponse.setFilterStartPriceValue(filterEntity.getFilterStartPriceValue());
			filterResponse.setFilterEndPriceStatus(filterEntity.getFilterEndPriceStatus());
			filterResponse.setFilterEndPriceValue(filterEntity.getFilterEndPriceValue());
			filterResponse.setFilterSeasonStatus(filterEntity.getFilterSeasonStatus());
			filterResponse.setFilterSeasonValue(filterEntity.getFilterSeasonValue());
			filterResponse.setFilterDurationStatus(filterEntity.getFilterDurationStatus());
			filterResponse.setFilterDurationValue(filterEntity.getFilterDurationValue());
			
			filterResponses.add(filterResponse);
		}
		
		return filterResponses;
	}

	@Override
	public FilterResponse insertFilter(FilterRequest filterRequest) {
		FilterResponse filterResponse = new FilterResponse();
		FilterEntity newFilterEntity = new FilterEntity();
		
		newFilterEntity.setFilterId(BaseUtility.generateId());
		newFilterEntity.setFilterStartPriceStatus(filterRequest.getFilterStartPriceStatus());
		newFilterEntity.setFilterStartPriceValue(filterRequest.getFilterStartPriceValue());
		newFilterEntity.setFilterEndPriceStatus(filterRequest.getFilterEndPriceStatus());
		newFilterEntity.setFilterEndPriceValue(filterRequest.getFilterEndPriceValue());
		newFilterEntity.setFilterSeasonStatus(filterRequest.getFilterSeasonStatus());
		newFilterEntity.setFilterSeasonValue(filterRequest.getFilterSeasonValue());
		newFilterEntity.setFilterDurationStatus(filterRequest.getFilterDurationStatus());
		newFilterEntity.setFilterDurationValue(filterRequest.getFilterDurationValue());
		
		FilterEntity insertedFilterEntity = filterRepository.save(newFilterEntity);
		
		if (BaseUtility.isObjectNotNull(insertedFilterEntity)) {
			filterResponse.setFilterId(insertedFilterEntity.getFilterId());
			filterResponse.setFilterStartPriceStatus(insertedFilterEntity.getFilterStartPriceStatus());
			filterResponse.setFilterStartPriceValue(insertedFilterEntity.getFilterStartPriceValue());
			filterResponse.setFilterEndPriceStatus(insertedFilterEntity.getFilterEndPriceStatus());
			filterResponse.setFilterEndPriceValue(insertedFilterEntity.getFilterEndPriceValue());
			filterResponse.setFilterSeasonStatus(insertedFilterEntity.getFilterSeasonStatus());
			filterResponse.setFilterSeasonValue(insertedFilterEntity.getFilterSeasonValue());
			filterResponse.setFilterDurationStatus(insertedFilterEntity.getFilterDurationStatus());
			filterResponse.setFilterDurationValue(insertedFilterEntity.getFilterDurationValue());
		}
		
		return filterResponse;
	}
}
