package com.umrah.service;

import java.util.List;

import com.umrah.dto.AdminRequest;
import com.umrah.dto.AdminResponse;
import com.umrah.dto.AgencyRequest;
import com.umrah.dto.AgencyResponse;
import com.umrah.dto.FilterRequest;
import com.umrah.dto.FilterResponse;
import com.umrah.dto.LoginRequest;
import com.umrah.dto.LoginResponse;

public interface UmrahService {

	List<AdminResponse> getAdmins();
	
	AdminResponse getAdminByAdminId(String adminId);
	
	LoginResponse adminLogin(LoginRequest loginRequest);
	
	AdminResponse insertAdmin(AdminRequest adminRequest);
	
	AdminResponse updateAdmin(AdminRequest adminRequest);
	
	Boolean deleteAdminByAdminId(String adminId);
	
	List<AgencyResponse> getAgencies();
	
	AgencyResponse getAgencyByAgencyId(String agencyId);
	
	AgencyResponse getAgencyByAdminId(String adminId);
	
	AgencyResponse insertAgency(AgencyRequest agencyRequest);
	
	AgencyResponse updateAgency(AgencyRequest agencyRequest);
	
	Boolean deleteAgencyByAgencyId(String agencyId);
	
	List<FilterResponse> getFilters();
	
	FilterResponse insertFilter(FilterRequest filterRequest);
}
