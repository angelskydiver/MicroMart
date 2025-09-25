package com.safalifter.filestorage.model;

import lombok.*;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity(name = "files")
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class File {
    @Id
    private String id;
    private String type;
    private String filePath;
}