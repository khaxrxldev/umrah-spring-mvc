package com.umrah.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.umrah.entity.AgencyEntity;

@Repository
public interface AgencyRepository extends JpaRepository<AgencyEntity, String> {
	
	AgencyEntity findByAgencyId(String agencyId);
	
	AgencyEntity findByAdminId(String adminId);

	Integer deleteByAgencyId(String agencyId);
}
