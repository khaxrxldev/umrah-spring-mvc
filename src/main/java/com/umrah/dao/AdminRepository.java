package com.umrah.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.umrah.entity.AdminEntity;

@Repository
public interface AdminRepository extends JpaRepository<AdminEntity, String> {

	AdminEntity findByAdminId(String adminId);

	AdminEntity findByAdminEmail(String adminEmail);

	Integer deleteByAdminId(String adminId);
}
