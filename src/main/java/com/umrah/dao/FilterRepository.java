package com.umrah.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


import com.umrah.entity.FilterEntity;

@Repository
public interface FilterRepository extends JpaRepository<FilterEntity, String> {
	
}
